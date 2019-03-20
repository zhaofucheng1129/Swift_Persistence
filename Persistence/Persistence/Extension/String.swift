//
//  String.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/20.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import Foundation

extension String {
    static var documentPath: String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }()
}

