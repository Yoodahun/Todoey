//
//  AppDelegate.swift
//  Todoey
//
//  Created by 유다훈 on 2018. 9. 18..
//  Copyright © 2018년 PandaYoo. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //Save Path
        print(Realm.Configuration.defaultConfiguration.fileURL)

        do  {
            // Create Realm DB Obeject
            let realm = try Realm();

        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        
        
        
        
        return true
    }

  
    
 
    
}

