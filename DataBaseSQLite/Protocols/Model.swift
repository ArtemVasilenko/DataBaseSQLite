import SQLite3
import Foundation

protocol DB {
    func createDataBase(url: URL) -> OpaquePointer?
    func createTableInDB(db: OpaquePointer, newTable: String)
    func insertInTable(db: OpaquePointer, inTable: String, name: String)
    func updateTableWithGuard(db: OpaquePointer, inTable: String, name: String, id: String)
    func selectFromTable(db: OpaquePointer, name: String, inTable: String, afterWhere: String) -> [String]
    func deleteInTable(db: OpaquePointer, inTable: String, id: String)
    func dropTable(db: OpaquePointer, inTable: String)
    func getListTable(db: OpaquePointer) -> [String]
    func anySelect(db: OpaquePointer, query: String) -> [String]
    func closeDB(db: OpaquePointer)
}

extension DB {
    
    func createDataBase(url: URL) -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        guard sqlite3_open(url.path, &db) == SQLITE_OK else {
            print("error creating DB \(Error.self)")
            return nil }
        print("create DataBase done \(url.path)")
        return db
    }
    
    func createTableInDB(db: OpaquePointer, newTable: String) {
        var table: OpaquePointer? = nil
        let query = """
        CREATE TABLE \(newTable) (
        "ID"    INTEGER PRIMARY KEY AUTOINCREMENT,
        "Name"    TEXT NOT NULL UNIQUE
        );
        """
        
        guard sqlite3_prepare_v2(db, query, -1, &table, nil) == SQLITE_OK else {
            print("prepare create table: error")
            return }
        print("query table done")
        
        guard sqlite3_step(table) == SQLITE_DONE else {
            print("table query error")
            return
        }
        print("create table \(newTable) done!")
        
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
        sqlite3_finalize(update)
        
    }
    
    func selectFromTable(db: OpaquePointer, name: String, inTable: String, afterWhere: String) -> [String] {
        var values = [String]()
        var str: OpaquePointer? = nil
        var query = "SELECT \(name) FROM \(inTable) "
        
        if afterWhere != "" {
            query += "WHERE \(afterWhere)"
        }
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil) == SQLITE_OK {
            print("query \(query) is DONE")
        } else {
            print("query \(query) is uncorrect")
        }
        
        while (sqlite3_step(str)) == SQLITE_ROW {
            let id = sqlite3_column_int(str, 0)
            let name = String(cString: sqlite3_column_text(str, 1))
            values.append(String(id) + " " + name)
        }
        
        return values
    }
    
    func deleteInTable(db: OpaquePointer, inTable: String, id: String) {
        var del: OpaquePointer? = nil
        let query = "DELETE FROM \(inTable) WHERE ID = \(id)"
        
        guard sqlite3_prepare_v2(db, query, -1, &del, nil) == SQLITE_OK else {
            print("error prepare deleting")
            return
        }
        print("Prepare delete done")
        
        guard sqlite3_step(del) == SQLITE_DONE else {
            print("error deleting")
            return
        }
        print("Delete done")
        sqlite3_finalize(del)
        
    }
    
    func dropTable(db: OpaquePointer, inTable: String) {
        var drop4ik: OpaquePointer? = nil
        let query = "DROP TABLE \(inTable)"
        
        guard sqlite3_prepare_v2(db, query, -1, &drop4ik, nil) == SQLITE_OK else {
            print("error preape drop")
            return
        }
        print("prepare drop done")
        
        guard sqlite3_step(drop4ik) == SQLITE_DONE else {
            print("error drop")
            return
        }
        print("drop done")
        sqlite3_finalize(drop4ik)
        
    }
    
    func getListTable(db: OpaquePointer) -> [String] {
        var values = [String]()
        var str: OpaquePointer? = nil
        let query = "select name from sqlite_master where type = 'table' and name <> 'sqlite_sequence'"
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil) == SQLITE_OK {
            print("query is DONE")
        } else {
            print("query is uncorrect")
        }
        
        while (sqlite3_step(str)) == SQLITE_ROW {
            let name = String(cString: sqlite3_column_text(str, 0))
            values.append(name)
        }
        
        return values
    }
    
    func anySelect(db: OpaquePointer, query: String) -> [String] {
        var values = [String]()
        var str: OpaquePointer? = nil
        
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil) == SQLITE_OK {
            print("Any query is DONE")
        } else {
            print("any guery is uncorrect")
        }
        
        while (sqlite3_step(str)) == SQLITE_ROW {
            var value = ""
            
            for i in 0..<sqlite3_column_count(str) {
                let name = String(cString: sqlite3_column_text(str, i))
                value += " " + name
            }
            values.append(value)
        }
        return values
    }
    
    func closeDB(db: OpaquePointer) {
        sqlite3_close(db)
    }
}

