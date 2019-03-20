//
//  Persion.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class Persion: NSObject, NSCoding {
    
    var name: String = "长泽雅美"
    var age: Int = 18
    var sex: String = "女"
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(sex, forKey: "sex")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")
        sex = aDecoder.decodeObject(forKey: "sex") as! String
        
    }
}
