import SQLite3
import Foundation

protocol DB {
    func removeDB(url: URL, fm: FileManager)
    func createURL(nameDB: String, fm: FileManager) -> URL
    func createDataBase(url: URL) -> OpaquePointer
    func createTableInDB(db: OpaquePointer, newTable: String)
    func insertInTable(db: OpaquePointer, inTable: String, name: String)
    func updateTable(db: OpaquePointer, inTable: String, name: String, id: String)
    func updateTableWithGuard(db: OpaquePointer, inTable: String, name: String, id: String)

    
}


extension DB {
    
    func createURL(nameDB: String, fm: FileManager) -> URL {
        var url = URL(fileURLWithPath: "")
        do {
            url = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(nameDB)
        } catch {
            print(error)
        }
        return url
    }
    
    func removeDB(url: URL, fm: FileManager) {
        do {
            try fm.removeItem(at: url)
        } catch {
            print("error delete DB")
        }
        
    }
    
    func createDataBase(url: URL) -> OpaquePointer {
        var db: OpaquePointer? = nil
        
        if sqlite3_open(url.path, &db) == SQLITE_OK {
            print("create done \(url.path)")
        } else {
            print("error creating bd \(Error.self)")
        }
        return db!
    }
    
    func createTableInDB(db: OpaquePointer, newTable: String) {
        var table: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, newTable, -1, &table, nil) == SQLITE_OK {
            if sqlite3_step(table) == SQLITE_DONE {
                print("table query")
            } else {
                print("table query error")
            }
        } else {
            print("prepare error")
        }
        
        sqlite3_finalize(table) //закрытие таблицы после изменений (транзакции)
    }
    
    func insertInTable(db: OpaquePointer, inTable: String, name: String) {
        var insert: OpaquePointer? = nil
        let insertString = """
        INSERT INTO \(inTable) (name) VALUES ('\(name)');
        """
        if sqlite3_prepare_v2(db, insertString, -1, &insert, nil) == SQLITE_OK {
            if sqlite3_step(insert) == SQLITE_DONE {
                print("insert new \(name) in \(inTable)")
            } else {
                print("error insert \(name)")
            }
        } else {
            print("error create new insert")
        }
        sqlite3_finalize(insert)
    }
    
    func updateTable(db: OpaquePointer, inTable: String, name: String, id: String) {
        var update: OpaquePointer? = nil
        let updateString = """
        UPDATE \(inTable) SET name = '\(name)' WHERE iD = \(id)
        """
        if sqlite3_prepare_v2(db, updateString, -1, &update, nil) == SQLITE_OK {
            
            if sqlite3_step(update) == SQLITE_DONE {
                print("update done")
            } else {
                print("update error")
            }
        } else {
            print("error prepare update ")
        }
        sqlite3_finalize(update)
    }
    
    func updateTableWithGuard(db: OpaquePointer, inTable: String, name: String, id: String) {
        var update: OpaquePointer? = nil
        let updateString = """
        UPDATE \(inTable) SET name = '\(name)' WHERE iD = \(id)
        """
        guard sqlite3_prepare_v2(db, updateString, -1, &update, nil) == SQLITE_OK,
            sqlite3_step(update) == SQLITE_DONE else {
                print("error create update")
                return
        }
        print("update whith guard done")
    }
}
