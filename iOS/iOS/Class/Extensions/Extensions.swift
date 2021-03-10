//
//  JsonServiceExtensions.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import Action
import DDMvvm
import RxSwift
import RxCocoa
import AVFoundation

extension String {
    
    var localization: String {
        return localizationManager.localizedStringForKey(self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func asDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter(withFormat: format, locale: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}

extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        return self == nil || self!.isEmpty
    }
}

extension Page {
    
    func setTitle(_ title: String) {
        navigationItem.setTitle(title.uppercased(), textColor: .navBarTitleColor, alignment: .center, font: helvetica.normal(withSize: 18))
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func hideNavigationBar(_ isEnabled: Bool = true) {
        navigationController?.setNavigationBarHidden(isEnabled, animated: false)
    }
    
}

//MARK: Extensions for cell view model to play sound when click button
extension CellViewModel {
    
    func playClickSound() {
        let systemSoundId: SystemSoundID = 1123
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
}


extension NSError {
    
    static let domain = Bundle.main.bundleIdentifier ?? ""
    
    static var mapperError: NSError {
        return NSError(domain: domain, code: 2000, userInfo: [NSLocalizedDescriptionKey: "Cannot mapping json to model."])
    }
}

extension UIColor {
    
    static let navBarTitleColor: UIColor = .fromHex("555A62")
    static let textColor: UIColor = .fromHex("A7665D")
    static let mainColor: UIColor = .fromHex("313130")
    
}

extension UIView {
    
    func borderView(_ radius: CGFloat = 25, _ color: UIColor = .white, _ width: CGFloat = 1) {
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
    }
    
}

extension Date {
    
    func asString(_ format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter(withFormat: format, locale: "en_US")
        return formatter.string(from: self)
    }
    
    var isoString: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return formatter.string(from: self)
    }
    
}

// MARK: Extension for Array
extension Array {
    
    // To safe access index of array
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}

// MARK: Extension for UIScrollView

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollTo(view:UIView, animated: Bool = true) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool = true) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
    // Scroll to a specific view so that it's top is at the top our scrollview HORIZONTAL
    func scrollToHorizontal(view:UIView, animated: Bool = true) {
        if let origin = view.superview {
            let point = origin.convert(view.frame.origin, to: self)
            scrollRectToVisible(CGRect(x: point.x, y: 0, width: frame.width, height: 1), animated: animated)
        }
    }
    
    // Bonus: Scroll to top HORIZONTAL
    func scrollToTopHorizontal(animated: Bool = true) {
        let offset = CGPoint(x: -contentInset.left, y: 0)
        setContentOffset(offset, animated: animated)
    }
    
    // Bonus: Scroll to bottom HORIZONTAL
    func scrollToBottomHorizontal() {
        let offset = CGPoint(x: contentSize.width - bounds.size.width + contentInset.right, y: 0)
        if(offset.x > 0) {
            setContentOffset(offset, animated: true)
        }
    }
    
}
