
import Foundation

class Engine: DB, FM {
    
    static var myEngine = Engine() //<---- СИНГЛ ТОН МАТЬ ЕГО!
    
    func createDBEngine(name: String) {
        myData.db = self.createDataBase(url: self.createURL(nameDB: name + ".db", fm: myData.fm))
    }
    
    func createTableInBDEngine(name: String) {
        createTableInDB(db: myData.db!, newTable: name)
        myData.arrTables.append(name)
        print("______ \(myData.arrTables)")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCellsInTableView"), object: nil)
    }
    
    func insertInTableEngine(name: String, inTable: String) {
        insertInTable(db: myData.db!, inTable: inTable, name: name)
    }
    
    func selectFromTheTableEngine(nameTable: String) -> [String] {
        var result = ["hello"]
        myData.arrTables = selectFromTable(db: myData.db!, name: "*", inTable: nameTable, afterWhere: "")
        
        myData.arrTables.forEach {
            result.append($0)
        }
        return result
    }
    
    func updateTableEngine(name: String, inTable: String, id: String) {
        updateTableWithGuard(db: myData.db!, inTable: inTable, name: name, id: id)
    }
}
