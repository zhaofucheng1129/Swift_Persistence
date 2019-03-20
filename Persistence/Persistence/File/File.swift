//
//  DoFile.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

//The methods of the shared NSFileManager object can be called from multiple threads safely. However, if you use a delegate to receive notifications about the status of move, copy, remove, and link operations, you should create a unique instance of the file manager object, assign your delegate to that object, and use that file manager to initiate your operations.

class File {
    
    //创建文件
    public func createFile() {
        let imageUrl = Bundle.main.url(forResource: "peppa", withExtension: "jpeg")!
        let documentPath = URL.documentUrl.appendingPathComponent("Peppa").appendingPathExtension("jpg").path
        print(documentPath)
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: imageUrl)
                if FileManager.default.createFile(atPath: documentPath, contents: data, attributes: nil) {
                    print("创建文件成功")
                }
            } catch {
                print("失败了 \(error)")
            }
        }
    }
    
    //创建文件夹
    public func createDirectory() {
        let directoryUrl = URL.documentUrl.appendingPathComponent("父文件夹", isDirectory: true).appendingPathComponent("子文件夹", isDirectory: true)
        print("文件夹路径: \(directoryUrl)")
        DispatchQueue.global().async {
            do {
                try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
                print("文件夹创建成功")
            } catch {
                print("失败了 \(error)")
            }
        }
    }
    
    //读取文件夹
    public func readDirectory() {
        DispatchQueue.global().async {
            if let enumerator = FileManager.default.enumerator(atPath: String.documentPath) {
                for case let path as String in enumerator {
                    print(path)
                }
            }
        }
    }
    
    // 删除文件夹
    public func deleteItem() {
        let directoryUrl = URL.documentUrl.appendingPathComponent("父文件夹", isDirectory: true)
        DispatchQueue.global().async {
            do {
                try FileManager.default.removeItem(at: directoryUrl)
                print("删除成功")
            } catch {
                print("失败了 \(error)")
            }
        }
    }
}
