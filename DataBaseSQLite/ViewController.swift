import UIKit
import SQLite3

class ViewController: UIViewController, DB {
    
    var fm = FileManager.default
    var url: URL?
    var nameDB = "DataBase_From_XCode_Project.db"
    var db: OpaquePointer?
    let createMyTable = #"""
        CREATE TABLE "MyTableFromXCode" (
        "ID"    INTEGER PRIMARY KEY AUTOINCREMENT,
        "Name"    TEXT NOT NULL UNIQUE
        );
        """#
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        url = createURL(nameDB: nameDB, fm: fm)
        removeDB(url: url!, fm: fm)
        db = createDataBase(url: url!)
        createTableInDB(db: db!, newTable: createMyTable)
        insertInTable(db: db!, inTable: "MyTableFromXCode", name: "Ignat")
        insertInTable(db: db!, inTable: "MyTableFromXCode", name: "Holodov")
        updateTable(db: db!, inTable: "MyTableFromXCode", name: "Ignat LOH", id: "1")
        updateTableWithGuard(db: db!, inTable: "MyTableFromXCode", name: "Hello Holodov", id: "2")
        
        sqlite3_close(db)
        
    }

    
}

