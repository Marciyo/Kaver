//
//  ExtendedTextField.swift
//  Eracoin App
//
//  Created by MARCELEEKEKEEKEKEK on 08.02.2117.
//  Copyright © 2077 MARCELEEKEKEEKEKEK MARCELEEKEKEEKEKEK. All rights reserved.
//

import UIKit

class ExtendedTextField: UIView, UITextFieldDelegate{
    
    let textField = UITextField.init()
    private var pattern: String = ""
    var onEndFunction : (() -> Void)?
    
    init(
        placeholder: String,
        pattern: String,
        keyboardType: UIKeyboardType,
        autocorrectionType: UITextAutocorrectionType,
        autocapitalizationType: UITextAutocapitalizationType,
        isSecure: Bool
        ){
        
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: 44),
                self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6)
            ]
        )
        self.pattern = pattern
        
        self.backgroundColor = UIColor.clear
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.attributedPlaceholder = NSAttributedString.init(
            string: placeholder,
            attributes:
            [
                NSForegroundColorAttributeName: UIColor.lightGray,
                NSFontAttributeName: UIFont.normal
            ]
        )
        self.textField.textColor = UIColor.white
        self.textField.font = UIFont.normal
        self.textField.textAlignment = .center
        self.textField.keyboardType = keyboardType
        self.textField.autocorrectionType = autocorrectionType
        self.textField.autocapitalizationType = autocapitalizationType
        self.textField.isSecureTextEntry = isSecure
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(self.textFieldValueChange(sender:)), for: UIControlEvents.editingChanged)
        self.textField.addTarget(self, action: #selector(self.textEndEdit(sender:)), for: UIControlEvents.editingDidEnd)
        self.textField.addTarget(self, action: #selector(self.textEndEditOnExit(sender:)), for: UIControlEvents.editingDidEndOnExit)
        
        self.addSubview(self.textField)
        
        self.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.textField,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.textField,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.textField,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.textField,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: -1
                )
            ]
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextResponder(nextField: UITextField){
        self.textField.addTarget(nextField, action: #selector(nextField.becomeFirstResponder), for: UIControlEvents.editingDidEndOnExit)
    }
    
    func isValid(emptyAllowed: Bool) -> Bool{
        
        guard
            let text = self.textField.text
            else {
                return false
        }
        return text.isValid(withPattern: self.pattern) || (text.isEmpty && emptyAllowed)
    }
    
    func setAs(valid:Bool){
        self.textField.textColor = valid ? UIColor.black : UIColor.red
        self.layer.borderColor = valid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
    }
    
    func textFieldValueChange(sender: UITextField){
        self.setAs(valid: self.isValid(emptyAllowed: true))
    }
    
    func textEndEdit(sender: UITextField){
        self.setAs(valid: self.isValid(emptyAllowed: false))
    }
    
    func textFieldDidBeginEditing(_ sender: UITextField) {
        self.setAs(valid: self.isValid(emptyAllowed: true))
    }
    
    func textEndEditOnExit(sender: UITextField){
        self.setAs(valid: self.isValid(emptyAllowed: false))
        
        guard
            let function = self.onEndFunction
            else{
                return
        }
        
        function()
    }
}
