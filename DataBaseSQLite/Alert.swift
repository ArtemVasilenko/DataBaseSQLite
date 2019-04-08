import Foundation
import UIKit
import SQLite3

class Alert: DB {
    var fm = FileManager.default
    var url: URL?
    let table = "MyTableFromXCodeGuard"
    var nameDB = "DataBase_From_XCode_Project.db"
    var db: OpaquePointer?
    
    func showAlert(inVC: UIViewController) {
        var name = String()
        
        let alert = UIAlertController(title: "Create Data Base", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            name = answer.text ?? ""
            
            self.db = self.createDataBase(url: self.createURL(nameDB: name + ".db", fm: self.fm))
            //getUrl = name + ".db"
            //db = createDB
            //            db = createDB(getURL(path: name + ".db"))
            
        }
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
    }
}
