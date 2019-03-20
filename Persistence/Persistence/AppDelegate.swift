//
//  AppDelegate.swift
//  Persistence
//
//  Created by 赵福成 on 2019/3/19.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var managedObjectContext: NSManagedObjectContext? = { [weak self] in
        if let persistentStoreCoordinator = self?.persistentStoreCoordinator {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = persistentStoreCoordinator
            return context
        }
        return nil
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        if let modelUrl = Bundle.main.url(forResource: "PersonModel", withExtension: "momd") {
            return NSManagedObjectModel(contentsOf: modelUrl)
        }
        return nil
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = { [weak self] in
        if let model = self?.managedObjectModel {
            let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            
            let sqliteUrl = URL.documentUrl.appendingPathComponent("coredata").appendingPathExtension("sqlite")
            let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                           NSInferMappingModelAutomaticallyOption: true]
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteUrl, options: options)
            } catch {
                print("存储协调器设置失败 \(error)")
                return nil
            }
            
            return coordinator
        }
        return nil
    }()
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

