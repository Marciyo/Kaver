//
//  Extensions.swift
//  Maklarappen
//
//  Created by MARCELINIOOOOOOOO
//  Copyright © 2018 Codeaddict. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func log(){
        print(self)
    }
    
    func isValid(withPattern pattern: String) -> Bool {
        
        do{
            let regEx = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let regExMaches = regEx.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: self.characters.count))
            if(regExMaches > 0){return true}
        }catch _{
            return false
        }
        
        return false
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func stringToImage() -> UIImage?{
        
        return UIImage.init(data: (NSData.init(contentsOf: NSURL.init(string: self) as! URL) ?? NSData.init()) as Data)
    }
    
    func dateFromString(format: String) -> Date? {
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale.init(identifier: "en-US")
        formatter.dateFormat = format
        guard
            let date = formatter.date(from: self)
            else{
                return nil
        }
        return date
    }
}

extension Date {
    
    func isToday() -> Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    func dateToString(format: String) -> String{
        let formatter = DateFormatter()
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        formatter.locale = locale as Locale!
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        var isEqualTo = false
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        return isEqualTo
    }
    
    func localDate() -> Date{
        
        var dayComponent = DateComponents.init()
        var theCalendar = Calendar.current
        theCalendar.timeZone = TimeZone.init(identifier: "GMT")!
        dayComponent = (Calendar.current as NSCalendar).components([NSCalendar.Unit.hour, NSCalendar.Unit.minute, .second, .day, .month, .year], from: self)
        return theCalendar.date(from: dayComponent)!
        
    }
    
}

extension UIFont {
    static let normal = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
    static let normalBold = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2, weight: 12)
    static let small = UIFont.systemFont(ofSize: UIFont.systemFontSize - 4)
    static let smallBold = UIFont.systemFont(ofSize: UIFont.systemFontSize - 4, weight: 12)
    static let big = UIFont.systemFont(ofSize: UIFont.systemFontSize + 4)
    static let bigBold = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize + 4)
    static let profileName = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: 24)
    static let huge = UIFont.systemFont(ofSize: UIFont.systemFontSize + 8)
    static let hugeBold = UIFont.systemFont(ofSize: UIFont.systemFontSize + 8, weight: 24)
    static let button = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2, weight: 24)
    static let menuButtons = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize + 1)
    static let title = UIFont.systemFont(ofSize: UIFont.systemFontSize + 7, weight: 24)
    
}

extension UIColor {
    
    static let main = UIColor(red:0.07, green:0.08, blue:0.15, alpha:1.00)
    static let facebook = UIColor(red:0.20, green:0.26, blue:0.66, alpha:1.00)
    static let googlePlus = UIColor(red:0.87, green:0.22, blue:0.15, alpha:1.00)
    static let separator = UIColor(red:0.16, green:0.17, blue:0.26, alpha:1.00)
    static let lightBlue = UIColor(red:0.24, green:0.67, blue:0.93, alpha:1.00)
    static let lightGreen = UIColor(red:0.13, green:0.88, blue:0.62, alpha:1.00)
    static let extraLightGray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.00)
    static let sectionLightGray = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00)
    
    struct wallet {
        static let facebookInvite = UIColor(red:0.09, green:0.12, blue:0.23, alpha:1.00)
        static let watchAd = UIColor(red:0.07, green:0.10, blue:0.20, alpha:1.00)
        static let shareLink = UIColor(red:0.07, green:0.10, blue:0.20, alpha:1.00)
        static let sendRecieveGifts = UIColor(red:0.09, green:0.16, blue:0.25, alpha:1.00)
        static let headerGray = UIColor(red:0.17, green:0.19, blue:0.28, alpha:1.00)
    }
    static let graphiteSearch = UIColor(red:0.14, green:0.15, blue:0.22, alpha:1.00)
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}

extension UIButton {
    func changeImageOnClick(imageOne: UIImage, imageTwo: UIImage){
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        }, completion: { (_) in
            UIView.animate(
                withDuration: 0.15,
                animations: {
                    if self.image(for: UIControlState.normal) == imageOne{
                        self.setImage(imageTwo, for: .normal)
                    }else{
                        self.setImage(imageOne, for: .normal)
                    }
                    self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
        })
    }
}

extension Double{
    func delay(closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self) {
            closure()
        }
    }
}
