//
//  MainViewController.swift
//  Kaver
//
//  Created by Marcel Mierzejewski on 03.03.2017.
//  Copyright © 2017 Marcel Mierzejewski. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init()
    var userData: [UserModel] = []
    
    var data: [ProductModel] = []
    var maxOffset = -1
    
    let realBackground = UIImageView.init()
    let fakeBackground = UIImageView.init()
    let testImage = UIImageView.init()
    let testLabel = UILabel.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "Kavior".localized
        
        self.realBackground.backgroundColor = UIColor.white
        self.realBackground.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.realBackground)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.realBackground,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.realBackground,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.realBackground,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.realBackground,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 150
                )
            ]
        )
        
        self.fakeBackground.backgroundColor = UIColor.main
        self.fakeBackground.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.fakeBackground)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.fakeBackground,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.fakeBackground,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.fakeBackground,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.fakeBackground,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 30
                )
            ]
        )
        
        self.testImage.translatesAutoresizingMaskIntoConstraints = false
        self.testImage.backgroundColor = UIColor.lightGray
        self.testImage.contentMode = .scaleAspectFit
        self.testImage.layer.cornerRadius = 60
        self.testImage.layer.masksToBounds = true

        self.view.addSubview(self.testImage)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.fakeBackground,
                    attribute: NSLayoutAttribute.top,
                    multiplier: 1.0,
                    constant: 10
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 12
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 1.0,
                    constant: 120
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 120
                )
            ]
        )
        
        self.testLabel.translatesAutoresizingMaskIntoConstraints = false
        self.testLabel.font = UIFont.normalBold
        self.testLabel.textAlignment = .left
        self.testLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(self.testLabel)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.testLabel,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.testImage,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 0.7,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.testLabel,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.testImage,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 16
                )
            ]
        )
        
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(BasicTableViewCell.self, forCellReuseIdentifier: "basic")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.tableView,
                    attribute: NSLayoutAttribute.top,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.realBackground,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.tableView,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.tableView,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.right,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.tableView,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: 0
                ),
                ]
        )
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: Constants.Keys.UserDataLoaded),object: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            print("User data loading")
            FlowManager.loadUser()
        })
        
    }
    
    //MARK: - UITableView Delegate & Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath) as! BasicTableViewCell
        let model = self.data[indexPath.row]

        cell.testImage.sd_setImage(with: URL.init(string: model.photo ?? ""))
        cell.testLabel.text = model.name ?? ""

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func refresh() {
        guard
            let user = FlowManager.currentUser
            else { return }
        
        self.testImage.sd_setImage(with: URL(string: user.avatar ?? ""))
        self.testLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        
        self.fetchData()
    }
    
    func fetchData(){
        Network.GetProducts().responseModel(successCompletion: { (list: ProductList ) in
            
            guard
                let items = list.list
                else { return }
            
            self.data = items
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }
}
