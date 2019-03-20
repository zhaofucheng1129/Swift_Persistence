//
//  CoreDataManager.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/21.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext? = {
       return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }()
    
    private override init() {
        super.init()
    }
    
    private func saveContext() {
        guard let context = context else {
            return
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func savePerson(name:String, age: Int16) {
        guard let context = context else {
            return
        }
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.name = name
        person.age = age
        saveContext()
    }
    
    func getAllPerson() {
        guard let context = context else {
            return
        }
        
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            if let _ = result.first {
                for person in result {
                    print("姓名：\(person.name ?? "") 年龄：\(person.age)")
                }
            } else {
                print("无数据")
            }
        } catch {
            print("错误\(error)")
        }
    }
    
    func getPersonWith(name: String) {
        guard let context = context, name != "" else {
            return
        }
        
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            if let _ = result.first {
                for person in result {
                    print("姓名：\(person.name ?? "") 年龄：\(person.age)")
                }
            } else {
                print("查无此人")
            }
        } catch {
            print("错误\(error)")
        }
    }
    
    func changePersonWith(name: String, newName: String, newAge: Int16) {
        guard let context = context, name != "" else {
            return
        }
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            if let _ = result.first {
                for person in result {
                    person.name = newName
                    person.age = newAge
                }
                
                saveContext()
            } else {
                print("无符合条件数据")
            }
        } catch {
            print("错误 \(error)")
        }
    }
    
    func deleteWith(name: String) {
        guard let context = context, name != "" else {
            return
        }
        
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            if let _ = result.first {
                for person in result {
                    context.delete(person)
                }
                saveContext()
            } else {
                print("无符合条件数据")
            }
        } catch {
            print("错误 \(error)")
        }
    }
    
    // 删除所有数据
    func deleteAllPerson() {
        guard let context = context else {
            return
        }
        
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            if let _ = result.first {
                for person in result {
                    context.delete(person)
                }
                saveContext()
            } else {
                print("无数据")
            }
        } catch {
            print("错误\(error)")
        }
    }
}
