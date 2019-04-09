import Foundation
import UIKit
import SQLite3

class Alert: DB {
    
    func alertCreateDB(inVC: UIViewController) {
        var name = String()
        
        let alert = UIAlertController(title: "Create Data Base", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            name = answer.text ?? ""
            
            myData.db = self.createDataBase(url: self.createURL(nameDB: name + ".db", fm: myData.fm))
        }
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
        
    }
    
    func alertCreateTable(inVC: UIViewController) {
        var name = String()
        
        let alert = UIAlertController(title: "Create Table", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            name = answer.text ?? ""
            
            self.createTableInDB(db: myData.db!, newTable: name)
            myData.arrTables.append(name)
            print("______ \(myData.arrTables)")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableView.reloadRows"), object: nil)
            
        }
        
        
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
