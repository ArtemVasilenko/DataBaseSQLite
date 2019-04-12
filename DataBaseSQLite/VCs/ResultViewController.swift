//
//  ResultViewController.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/11/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var nameTable = String()
    
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var textFieldAppend: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAppend(_ sender: UIButton) {
        
        Engine.myEngine.insertInTableEngine(name: textFieldAppend.text ?? "", inTable: nameTable)
        resultTable.reloadData()
    }
    
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Engine.myEngine.selectFromTheTableEngine(nameTable: self.nameTable).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = Engine.myEngine.selectFromTheTableEngine(nameTable: self.nameTable)[indexPath.row]
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
