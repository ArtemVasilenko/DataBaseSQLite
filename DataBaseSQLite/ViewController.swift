import UIKit
//import SQLite3

class ViewController: UIViewController, DB {
    
    var createDbAlert = Alert()
    
//    var fm = FileManager.default
//    var url: URL?
//    let table = "MyTableFromXCodeGuard"
//    var nameDB = "DataBase_From_XCode_Project.db"
//    var db: OpaquePointer?
    let createMyTable = #"""
        CREATE TABLE "MyTableFromXCodeGuard" (
        "ID"    INTEGER PRIMARY KEY AUTOINCREMENT,
        "Name"    TEXT NOT NULL UNIQUE
        );
        """#
    
    let createMyTable2 = #"""
        CREATE TABLE "MyTable" (
        "ID"    INTEGER PRIMARY KEY AUTOINCREMENT,
        "Name"    TEXT NOT NULL UNIQUE
        );
        """#
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        url = createURL(nameDB: nameDB, fm: fm)
//        removeDB(url: url!, fm: fm)
//        db = createDataBase(url: url!)
//        createTableInDB(db: db!, newTable: createMyTable)
//        createTableInDB(db: db!, newTable: createMyTable2)
//
//        insertInTable(db: db!, inTable: self.table, name: "Ignat")
//        insertInTable(db: db!, inTable: self.table, name: "Holodov")
//
//        updateTableWithGuard(db: db!, inTable: self.table, name: "Hi Holodov", id: "2")
//
//        print(selectFromTable(db: db!, name: "*", inTable: self.table, afterWhere: ""))
//
//        deleteInTable(db: db!, inTable: self.table, id: "1")
//
//        print(selectFromTable(db: db!, name: "*", inTable: self.table, afterWhere: ""))
//        
//        print(getListTable(db: db!))
//
//        print(anySelect(db: db!, query: "SELECT * FROM \(self.table)"))
//
//        //        dropTable(db: db!, inTable: self.table)
//        closeDB(db: db!)
    }
    
    
    @IBAction func btnCreateDB(_ sender: UIButton) {
        createDbAlert.showAlert(inVC: self)
        
    }
}

