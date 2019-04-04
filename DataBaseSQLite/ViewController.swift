import UIKit
import SQLite3

class ViewController: UIViewController, DB {
    
    var fm = FileManager.default
    var url: URL?
    var nameDB = "DataBase_From_XCode_Project.db"
    var db: OpaquePointer?
    let createMyTable = #"""
        CREATE TABLE "MyTableFromXCodeGuard" (
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
        insertInTable(db: db!, inTable: "MyTableFromXCodeGuard", name: "Ignat")
        insertInTable(db: db!, inTable: "MyTableFromXCodeGuard", name: "Holodov")
    
        updateTableWithGuard(db: db!, inTable: "MyTableFromXCodeGuard", name: "Hi Holodov", id: "2")
        
        sqlite3_close(db)
        
    }
}

