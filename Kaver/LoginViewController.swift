//
//  LoginViewController.swift
//  Eracoin App
//
//  Created by Maciej Matuszewski on 08.02.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit
import KVNProgress
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage

class LoginViewController: UIViewController {

    let emailField = ExtendedTextField.init(
        placeholder: "E-mail".localized,
        pattern: Constants.Paterns.Email,
        keyboardType: UIKeyboardType.emailAddress,
        autocorrectionType: UITextAutocorrectionType.no,
        autocapitalizationType: UITextAutocapitalizationType.none,
        isSecure: false
    )
    
    let passwordField = ExtendedTextField.init(
        placeholder: "Password".localized,
        pattern: Constants.Paterns.Password,
        keyboardType: UIKeyboardType.default,
        autocorrectionType: UITextAutocorrectionType.no,
        autocapitalizationType: UITextAutocapitalizationType.none,
        isSecure: true
    )
    
    let loginButton = UIButton.init()
    
    let imageURL = URL.init(string: "https://raw.githubusercontent.com/google/physical-web/master/documentation/images/logo/logo-black.png")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let redBackground = UIImageView.init()
        redBackground.translatesAutoresizingMaskIntoConstraints = false
        redBackground.backgroundColor = UIColor.extraLightGray
        self.view.addSubview(redBackground)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: redBackground,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: redBackground,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: redBackground,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: redBackground,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
        let whiteBackground = UIImageView.init()
        whiteBackground.translatesAutoresizingMaskIntoConstraints = false
        whiteBackground.backgroundColor = UIColor.white
        whiteBackground.layer.cornerRadius = 8
        self.view.addSubview(whiteBackground)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: whiteBackground,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: whiteBackground,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: whiteBackground,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 0.7,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: whiteBackground,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 0.8,
                    constant: 0
                )
            ]
        )
        
        let logoView = UIImageView.init()
        logoView.sd_setImage(with: imageURL)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.contentMode = .scaleAspectFill
        self.view.addSubview(logoView)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: logoView,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: whiteBackground,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 60
                ),
                NSLayoutConstraint.init(
                    item: logoView,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: logoView,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 90
                ),
                NSLayoutConstraint.init(
                    item: logoView,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: logoView,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 0
                ),
            ]
        )
        
        self.emailField.setNextResponder(nextField: self.passwordField.textField)
        self.view.addSubview(self.emailField)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.emailField,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.greaterThanOrEqual,
                    toItem: logoView,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 46
                ),
                NSLayoutConstraint.init(
                    item: self.emailField,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
            ]
        )
        
        self.passwordField.onEndFunction = {
            self.login()
        }
        
        self.view.addSubview(self.passwordField)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.passwordField,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.emailField,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 8
                ),
                NSLayoutConstraint.init(
                    item: self.passwordField,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
            ]
        )
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setTitle("LOG IN", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.login), for: UIControlEvents.touchUpInside)
        self.loginButton.backgroundColor = UIColor.darkGray
        self.loginButton.layer.cornerRadius = 6
        self.view.addSubview(self.loginButton)

        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.loginButton,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: whiteBackground,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.loginButton,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: whiteBackground,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.loginButton,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 50
                ),
                NSLayoutConstraint.init(
                    item: self.loginButton,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: whiteBackground,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
    }

    
    func login(){
        var valid = true
        if !self.emailField.isValid(emptyAllowed: false){
            self.emailField.setAs(valid: false)
            valid = false
        }
        if !self.passwordField.isValid(emptyAllowed: false){
            self.passwordField.setAs(valid: false)
            valid = false
        }
        if !valid {
            return
        }
        print("Login...")
        KVNProgress.show()
        Network.Login(email: self.emailField.textField.text ?? "", password: self.passwordField.textField.text ?? "")
            .responseModel(
                successCompletion: { (model: UserModel) in
                    
                    guard
                        let apiToken = model.token,
                        let mail = model.email
                    else{
                        KVNProgress.showError()
                        return
                    }
                    
                    FlowManager.currentUser = model
                    
                    Configuration.saveAuthorization(authorization: apiToken)
                    Configuration.saveUserMail(userMail: mail)
                    
                    KVNProgress.showSuccess(withStatus: "Witaj")
                    FlowManager.loadMain()
                    
            }) { (errorMessage) in
                errorMessage.log()
                KVNProgress.showError(withStatus: errorMessage)
        }
    }
}
