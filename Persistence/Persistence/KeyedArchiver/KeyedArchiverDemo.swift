//
//  KeyedArchiverDemo.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/20.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class KeyedArchiverDemo {
    public func savePerson() {
        //NSKeyedArchiver
        //写入
        let path = URL.documentUrl.appendingPathComponent("person")
        print(path)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: Persion(), requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print("归档失败了")
        }
    }
    
    public func readPerson() {
        //读取
        let path = URL.documentUrl.appendingPathComponent("person")
        do {
            if let data = FileManager.default.contents(atPath: path.path),let person = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Persion {
                print("名字是：\(person.name)")
            }
        } catch {
            print("解档失败了 \(error)")
        }
    }
}
