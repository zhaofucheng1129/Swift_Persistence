//
//  ReadSettingsBundle.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class ReadSettingsBundle {
    public func readSettings() {
        let defaults = UserDefaults.standard
        print("用户名：\(defaults.string(forKey: "user_name") ?? "")")
        print("密码是:\(defaults.string(forKey: "password") ?? "")")
        print("选项是: \(defaults.string(forKey: "options") ?? "")")
        print("音乐：\(defaults.bool(forKey: "music_switch"))")
        print("音量：\(defaults.float(forKey: "music_value"))")
        
    }
}
