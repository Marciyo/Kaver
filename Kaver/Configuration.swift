//
//  Configuration.swift
//  Maklarappen
//
//  Created by Maciej Matuszewski on 13.09.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import UIKit
import KeychainAccess

class Configuration {
    
    static func saveUserMail(userMail: String) {
        let keychain = Keychain(service: Constants.Keys.KeychainBundle)
        do {
            try keychain
                .synchronizable(true)
                .set(userMail, key: Constants.Keys.KeychainUserMailKey)
            
        } catch let error {
            "\(self) - error: \(error)".log()
            return
        }
    }
    
    static func saveAuthorization(authorization: String) {
        let keychain = Keychain(service: Constants.Keys.KeychainBundle)
        do {
            try keychain
                .synchronizable(true)
                .set("\(authorization)", key: Constants.Keys.KeychainAuthorizationKey)
            
        } catch let error {
            "\(self) - error: \(error)".log()
            return
        }
    }
    
    static func getUserMail() -> String? {
        return Keychain(service: Constants.Keys.KeychainBundle)[Constants.Keys.KeychainUserMailKey]
    }
    
    static func getAuthorization() -> String? {
        return Keychain(service: Constants.Keys.KeychainBundle)[Constants.Keys.KeychainAuthorizationKey]
    }
}
