import SQLite3
import Foundation

protocol DB {
    func removeDB(url: URL, fm: FileManager)
    func createURL(nameDB: String, fm: FileManager) -> URL
    func createDataBase(url: URL) -> OpaquePointer?
    func createTableInDB(db: OpaquePointer, newTable: String)
    func insertInTable(db: OpaquePointer, inTable: String, name: String)
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
    
    func createDataBase(url: URL) -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        guard sqlite3_open(url.path, &db) == SQLITE_OK else {
            print("error creating bd \(Error.self)")
            return nil }
        print("create done \(url.path)")
        return db
    }
    
    func createTableInDB(db: OpaquePointer, newTable: String) {
        var table: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(db, newTable, -1, &table, nil) == SQLITE_OK else {
            print("prepare error")
            return }
        guard sqlite3_step(table) == SQLITE_DONE else {
            print("table query error")
            return
        }
        print("table query")
        
        sqlite3_finalize(table) //закрытие таблицы после изменений (транзакции)
    }
    
    func insertInTable(db: OpaquePointer, inTable: String, name: String) {
        var insert: OpaquePointer? = nil
        let insertString = """
        INSERT INTO \(inTable) (name) VALUES ('\(name)');
        """
        guard sqlite3_prepare_v2(db, insertString, -1, &insert, nil) == SQLITE_OK,
            sqlite3_step(insert) == SQLITE_DONE else {
                print("error insert in table")
                return
        }
        print("insert in table done")
        sqlite3_finalize(insert)
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
