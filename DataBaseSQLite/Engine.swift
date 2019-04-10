//
//  Engine.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/10/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import Foundation

class Engine: DB {
    
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
}
