//
//  PlistDemo.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class PlistDemo {
    public func saveToPlist() {
        let dict: NSDictionary = [
            "error_code": 0,
            "message": "成功",
            "list" : [
                ["name": "张三", "age": 18],
                ["name": "李四", "age": 20]
            ]
        ]
        
        let path = URL.documentUrl.appendingPathComponent("dict").appendingPathExtension("plist").path
        
        print("Docunemt Path: \(path)")

        dict.write(toFile: path, atomically: true)
    }
    
    public func readPlist() {
        let path = URL.documentUrl.appendingPathComponent("dict").appendingPathExtension("plist").path
        
        print("Docunemt Path: \(path)")
        
        if let dict = NSDictionary(contentsOfFile: path) {
            print(dict)
        }
    }
}
