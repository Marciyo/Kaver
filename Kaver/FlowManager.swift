//
//  FlowMenager.swift
//  Maklarappen
//
//  Created by Maciej Matuszewski on 20.10.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import UIKit
import MMDrawerController
import KeychainAccess

class FlowManager {
    
    static var currentUser: UserModel?
    
    static var drawerController: MMDrawerController?
    
    static func loadInitialView(){
            self.loadLogin()
    }
    
    static func loadLogin(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                fatalError()
        }
        
        let navigationController = UINavigationController.init(rootViewController: LoginViewController())
        navigationController.isNavigationBarHidden = true
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    static func loadMain(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                fatalError()
        }
        
        if self.currentUser == nil{
            self.loadUser()
        }
        
        let navigationController = ExtendedNavigationController.init(rootViewController: MainViewController())
        navigationController.isNavigationBarHidden = false
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    static func loadUser(){
        Network.GetMe().responseModel(
            successCompletion: { (model: UserModel) in
                self.currentUser = model
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Keys.UserDataLoaded), object: nil)
        }) { (_) in
            1.0.delay {
                self.loadUser()
            }
        }
    }

}
