//
//  Initializers.swift
//  Maklarappen
//
//  Created by Maciej Matuszewski on 13.09.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import UIKit
import UserNotifications
import IQKeyboardManager
import Firebase
import KVNProgress

class Initializers {
    
    static func initializeAll(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        
        
        if !UIDevice.isSimulator{
            FIRApp.configure()
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                if granted {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
    
    static func initializeIQKeyboardManager(){
        IQKeyboardManager.shared().isEnabled = true
    }
}
