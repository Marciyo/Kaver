//
//  ExtendedNavigationController.swift
//  Eracoin App
//
//  Created by Maciej Matuszewski on 17.02.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class ExtendedNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [rootViewController]
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.main
        self.navigationBar.barStyle = .black
        self.navigationBar.tintColor = UIColor.extraLightGray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
