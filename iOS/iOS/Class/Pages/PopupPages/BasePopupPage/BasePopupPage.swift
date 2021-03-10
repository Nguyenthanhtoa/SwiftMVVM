//
//  PopupPage.swift
//  iOS
//
//  Created by ThanhToa on 2/20/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import Action
import RxCocoa
import RxSwift
import DDMvvm

class BasePopupPage: NavigationPage, IPopupView {
    
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    func popupLayout() {
        view.cornerRadius = 7
        view.autoCenterInSuperview()
        widthConstraint = view.autoSetDimension(.width, toSize: screenSize.width - 60)
        heightConstraint = view.autoSetDimension(.height, toSize: 120)
    }
    
    func show(overlayView: UIView) {
        view.layoutIfNeeded()
        
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            overlayView.alpha = 0.3
            self.view.transform = .identity
        }, completion: nil)
    }
    
    func hide(overlayView: UIView, completion: @escaping (() -> ())) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 0
            self.view.alpha = 0
            self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            completion()
        }
    }
    
}
