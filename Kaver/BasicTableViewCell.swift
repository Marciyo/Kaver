//
//  BasicTableViewCell.swift
//  Kaver
//
//  Created by Marcel Mierzejewski on 03.03.2017.
//  Copyright © 2017 Marcel Mierzejewski. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    
    let testImage = UIImageView.init()
    let testLabel = UILabel.init()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.testImage.translatesAutoresizingMaskIntoConstraints = false
        self.testImage.backgroundColor = UIColor.lightGray
        self.testImage.contentMode = .scaleAspectFit
        self.testImage.layer.cornerRadius = 35
        self.testImage.contentMode = .scaleAspectFill
        self.testImage.layer.masksToBounds = true

        self.addSubview(self.testImage)
        
        self.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.left,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: 12
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 1.0,
                    constant: 70
                ),
                NSLayoutConstraint.init(
                    item: self.testImage,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.height,
                    multiplier: 1.0,
                    constant: 70
                ),
            ]
        )
        
        self.testLabel.translatesAutoresizingMaskIntoConstraints = false
        self.testLabel.font = UIFont.normalBold
        self.testLabel.textAlignment = .left
        self.testLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(self.testLabel)
        self.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.testLabel,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
