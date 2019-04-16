import UIKit

class Alert {
    
    func alertCreateDB(inVC: UIViewController) {
        var name = String()
        
        let alert = UIAlertController(title: "Create Data Base", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            name = answer.text ?? ""
            
            Engine.myEngine.createDBEngine(name: name) //<--- сингл Тон
            
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
            
            Engine.myEngine.createTableInBDEngine(name: name)
            
        }
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
    }
    
    func alertUpdateTable(inVC: UIViewController, inTable: String, id: Int) {
        var name = String()

        let alert = UIAlertController(title: "Edit", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            name = answer.text ?? ""
            
            Engine.myEngine.updateTableEngine(name: name, inTable: inTable, id: String(id))
            
        }
        
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
        
    }
    
}
