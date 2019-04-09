import UIKit

class ViewController: UIViewController, DB {
    var alert = Alert()
    
    @IBOutlet var controlButtons: [UIButton]!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        myTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        
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
    
    
    @IBAction func actionButtons(_ sender: UIButton) {
        
        guard let actionEventNumber = getInfo(rawValue: controlButtons.firstIndex(of: sender)!) else { return }
        
        switch actionEventNumber {
        case .createBD: alert.alertCreateDB(inVC: self)
            
        case .createTable: alert.alertCreateTable(inVC: self)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .darkGray
        
        let label = UILabel(frame: CGRect(x: 70, y: 70, width: cell.frame.width, height: 36))
        label.text = myData.arrTables[indexPath.row]
        cell.addSubview(label)
        
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myData.arrTables.count
    }
}

