//
//  GlobalHud.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import DDMvvm

class GlobalHud: UIView {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    private static var drawerPage: DrawerPage {
        return UIApplication.shared.windows
            .filter { $0.rootViewController is DrawerPage }
            .first?.rootViewController as! DrawerPage
    }
    
    private static var rootPage: UIViewController {
        return getTopMostController()
    }
    
    private static let tag = 10001
    
    override func awakeFromNib() {
        backgroundColor = .clear
        
        holderView.cornerRadius = 5
        holderView.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.5)
        
        indicatorView.color = .white
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        
        label.font = helvetica.normal(withSize: 16)
        label.textColor = .white
    }
    
    static func show(withTitle title: String) {
        if let hud = rootPage.view.viewWithTag(tag) as? GlobalHud {
            hud.label.text = title
        } else {
            let hud: GlobalHud! = UIView.loadFrom(nibNamed: "GlobalHud")
            hud.tag = tag
            hud.label.text = title
            hud.holderView.alpha = 0
            rootPage.view.addSubview(hud)
            hud.autoPinEdgesToSuperviewEdges()
            
            UIView.animate(withDuration: 0.25) {
                hud.holderView.alpha = 1
            }
        }
    }
    
    static func hide() {
        if let hud = rootPage.view.viewWithTag(tag) as? GlobalHud {
            UIView.animate(withDuration: 0.25, animations: {
                hud.holderView.alpha = 0
            }) { _ in
                hud.removeFromSuperview()
            }
        }
    }
    
    // MARK: Get top view controller
    static func getTopMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
//        if topController is LGSideMenuController {
//            if let root = (topController as! LGSideMenuController).rootViewController {
//                return root
//            }
//        }
        
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        
        return topController
    }
}
