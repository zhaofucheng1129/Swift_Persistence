//
//  URL.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/20.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import Foundation

extension URL {
    static var documentUrl: URL = {
       return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }()
}
