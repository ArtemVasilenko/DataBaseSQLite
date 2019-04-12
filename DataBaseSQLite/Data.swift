//
//  Data.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/9/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import Foundation

enum getInfo: Int {
    case createBD
    case createTable
}

struct myData {
    
    static var fm = FileManager.default
    static var url: URL?
    static let table = ""
    static var nameDB = ""
    static var db: OpaquePointer?
    static var arrTables = [String]()
    
}
