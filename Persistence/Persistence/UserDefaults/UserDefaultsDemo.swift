//
//  UserDefaultsDemo.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class UserDefaultsDemo {
    
    public func testData() {
        let defaults = UserDefaults.standard
        
        defaults.set("测试一段数据", forKey: "test_data")
        
        //-synchronize is deprecated and will be marked with the NS_DEPRECATED macro in a future release.
//        defaults.synchronize()
        
        print(defaults.string(forKey: "test_data") ?? "")
        
    }
    
}
