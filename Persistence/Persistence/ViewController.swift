//
//  ViewController.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("读取 UserDefualts \n")
//        UserDefaultsDemo().testData()
//
//        print("\n\n读取Setting Bundle \n")
//        ReadSettingsBundle().readSettings()
//
//        PlistDemo().readPlist()
        
        
        
        //文件操作测试
//        let f = File()
//        f.createFile()
//        f.createDirectory()
//        f.readDirectory()
//        f.deleteItem()
        
        

        
        //SQLite操作
//        let db = SQLiteDB()
//        _ = db.createDB()
//        db.createTable()
//        db.insert()
//        db.remove(ids: [1,3,5,7])
//        db.update(id: 10)
//        db.query(lessThan: 10)
//        db.dropTable()
//        db.closeDB()

        let coredata = CoreDataManager.shared
//        coredata.savePerson(name: "长泽雅美", age: 32)
//        coredata.savePerson(name: "新垣结衣", age: 31)
//        coredata.getAllPerson()
//        coredata.getPersonWith(name: "新垣结衣")
//        coredata.changePersonWith(name: "长泽雅美", newName: "哈哈哈", newAge: 31)
//        coredata.getAllPerson()
//        coredata.changePersonWith(name: "哈哈哈", newName: "长泽雅美", newAge: 32)
//        coredata.getAllPerson()
//        coredata.deleteWith(name: "新垣结衣")
//        coredata.getAllPerson()
//        coredata.savePerson(name: "新垣结衣", age: 31)
//        coredata.getAllPerson()
        
    }


}

