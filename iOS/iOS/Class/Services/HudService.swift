//
//  HudService.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit

protocol IHudService {
    
    func showHud(_ text: String)
    func hideHud()
}

extension IHudService {
    
    func showHud(_ text: String = "Loading...") {
        showHud(text)
    }
}

class HudService: IHudService {
    
    func showHud(_ text: String) {
        GlobalHud.show(withTitle: text)
    }
    
    func hideHud() {
        GlobalHud.hide()
    }
}









