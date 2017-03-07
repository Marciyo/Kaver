//
//  Constans.swift
//  Maklarappen
//
//  Created by Maciej Matuszewski on 13.09.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    enum Env {
        case Dev
        case Prod
    }
    
    static let BuildEnv: Env = .Dev
    
    struct Paterns {
        static let Anything = "^.*$"
        static let Email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        static let Password = "^[A-Z0-9a-z!@#$%^&*()]{6,}$"
		static let Phone = "^[+]?([ ]*[0-9][ ]*){9,20}$"
		static let ZipCode = "^[0-9]{3}[ -]?[0-9]{2}$"
		static let Name = "^[a-zA-ZÅåÄäÆæÖö']+[ ]+[a-zA-ZÅåÄäÆæÖö']+([ |-]?[a-zA-ZÅåÄäÆæÖö'])*$"
    }
    
    struct Keys {
        static let KeychainBundle = Bundle.main.bundleIdentifier!
        static let KeychainUserMailKey = "KeychainUserMailKey"
        static let KeychainAuthorizationKey = "KeychainAuthorizationKey"
        static let UserDataLoaded = "UserDataLoaded"
        
    }
    
    static let kServerURL = BuildEnv == .Dev ? "http://outfits.mobi/api/v1/user/" : "https://api.server.com"
}
