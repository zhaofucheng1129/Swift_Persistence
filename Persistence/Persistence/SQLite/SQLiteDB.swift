//
//  SQLiteDB.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit

class SQLiteDB {
    private var db:OpaquePointer? = nil
    private lazy var fm = {
        return FileManager.default
    }()
    
    
    private lazy var dbPath = { [weak self] () -> String in
        let documentPath = self?.fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = documentPath!.appendingPathComponent("data").appendingPathExtension("db").path
        return dbPath
    }()
    
    public func createDB() -> Bool {
        if !fm.isExecutableFile(atPath: dbPath) {
            if fm.createFile(atPath: dbPath, contents: nil, attributes: nil) {
                return openDB()
            } else {
                print("数据库创建失败")
                return false
            }
        } else {
            return openDB()
        }
    }
    
    private func openDB() -> Bool {
        let cPath = dbPath.cString(using: .utf8)!
        let error = sqlite3_open(cPath, &db)
        
        if error != SQLITE_OK {
            print("数据库打开失败")
            sqlite3_close(db)
            return false
        }
        
        print("数据库打开成功")
        return true
    }
    
    public func createTable() {
        assert(db != nil, "数据库没有正确打开")
        
        let createTableSql = "create table if not exists t_user(uid integer primary key AUTOINCREMENT,uname varchar(20),mobile varchar(20))"
        
        let cSql = createTableSql.cString(using: .utf8)
        var errMsg: UnsafeMutablePointer<Int8>?
        let result = sqlite3_exec(db, cSql!, nil, nil, &errMsg)
        
        if result != SQLITE_OK {
            sqlite3_free(errMsg)
            if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                print("SQLiteDB - failed to prepare SQL: \(createTableSql), Error: \(error)")
            }
            return
        }
        sqlite3_free(errMsg)
        
        print("创建成功")
    }
    
    public func insert() {
        assert(db != nil, "数据库没有正确打开")
        
        print("插入数据开始")
        beginTransaction()
        
        var stmt: OpaquePointer?
        var sql = ""
        var cSql:[CChar]?
        for i in 0...100 {
            sql = "insert into t_user(uname,mobile) values('user\(i)','13\(i)')"
            cSql = sql.cString(using: .utf8)
            if sqlite3_prepare_v2(db, cSql!, -1, &stmt, nil) != SQLITE_OK {
                sqlite3_finalize(stmt)
                print("执行失败")
                rollback()
                break
            } else {
                if sqlite3_step(stmt) != SQLITE_DONE {
                    sqlite3_finalize(stmt)
                    print("执行失败")
                    rollback()
                    break
                }
            }
        }
        sqlite3_finalize(stmt)
        
        commitTransaction()
        print("插入数据成功")
        
    }
    
    //开启事物
    private func beginTransaction() {
        var errMsg: UnsafeMutablePointer<Int8>?
        //开启事物
        //SQL国际标准使用START TRANSACTION开始一个事务（也可以用方言命令BEGIN）。COMMIT语句使事务成功完成。ROLLBACK语句结束事务，放弃从BEGIN TRANSACTION开始的一切变更。若autocommit被START TRANSACTION的使用禁止，在事务结束时autocommit会重新激活。
        let result = sqlite3_exec(db, "BEGIN", nil, nil, &errMsg)
        
        if result != SQLITE_OK {
            sqlite3_free(errMsg)
            print("启动事物失败")
            return
        }
        
        sqlite3_free(errMsg)
        print("启动事物成功")
    }
    
    //提交事物
    private func commitTransaction() {
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, "COMMIT", nil, nil, &errMsg) != SQLITE_OK {
            sqlite3_free(errMsg)
            print("提交事物失败")
            rollback()
        }
        
        sqlite3_free(errMsg)
        print("提交事物成功")
    }
    
    //回滚事物
    private func rollback() {
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, "ROLLBACK", nil, nil, &errMsg) == SQLITE_OK {
            print("回滚成功")
        } else {
            print("回滚失败")
        }
        sqlite3_free(errMsg)
    }
    
    public func remove(ids:[Int]) {
        if ids.count <= 0 {
            return
        }
        
        print("删除数据开始")
        
        beginTransaction()
        
        var errMsg: UnsafeMutablePointer<Int8>?
        var sql = ""
        var cSql:[CChar]?
        for id in ids {
            sql = "delete from t_user where uid = \(id)"
            cSql = sql.cString(using: .utf8)
            if sqlite3_exec(db, cSql, nil, nil, &errMsg) != SQLITE_OK {
                sqlite3_free(errMsg)
                if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                    print("SQLiteDB - 执行SQL: \(sql), Error: \(error)")
                }
                rollback()
                return
            }
        }
        
        commitTransaction()
        sqlite3_free(errMsg)
        
        print("删除数据成功")
    }
    
    public func update(id:Int) {
        
        print("开始更新")
        
        let sql = "update t_user set uname = '长泽雅美' where uid = \(id)"
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql.cString(using: .utf8), nil, nil, &errMsg) != SQLITE_OK {
            sqlite3_free(errMsg)
            if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                print("SQLiteDB - 执行SQL: \(sql), Error: \(error)")
            }
            return
        }
        
        sqlite3_free(errMsg)
        print("更新结束")
        
    }
    
    public func query(lessThan: Int) {
        print("执行查询")
        let sql = "select * from t_user where uid < ?"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, sql.cString(using: .utf8), -1, &stmt, nil) != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                print("准备SQL: \(sql), Error: \(error)")
            }
            return
        }
        print("查询编译成功")
        
        if sqlite3_bind_int(stmt, 1, CInt(lessThan)) != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8:sqlite3_errmsg(self.db)) {
                let msg = "绑定参数 SQL: \(sql), uid: \(lessThan), 位置: \(1) Error: \(error)"
                NSLog(msg)
            }
            return
        }
        
        print("查询执行成功")
        
        //循环取得每一行
        while sqlite3_step(stmt) == SQLITE_ROW {
            let columnCount = sqlite3_column_count(stmt)
            let uid = sqlite3_column_int(stmt, 0)
            let uname = String(cString: sqlite3_column_text(stmt, 1))
            let mobile = String(cString: sqlite3_column_text(stmt, 2))
            print("每条记录有\(columnCount)列，第一列uid:\(uid), 第二列uname:\(uname),第三列mobile:\(mobile)")
        }
        
        sqlite3_finalize(stmt)
        print("查询结束")
    }
    
    public func dropTable() {
        let sql = "drop table if exists t_user"
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql.cString(using: .utf8), nil, nil, &errMsg) != SQLITE_OK {
            sqlite3_free(errMsg)
            if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                print("删除表失败 SQL: \(sql), Error: \(error)")
            }
            return
        }
        
        
        print("删除表成功")
    }
    
    public func closeDB() {
        if db != nil {
            let result = sqlite3_close_v2(db)
            
            if result != SQLITE_OK {
                if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                    print("关闭数据库失败 Error: \(error)")
                }
            } else {
                print("关闭数据库成功")
            }
        }
        
    }
}
