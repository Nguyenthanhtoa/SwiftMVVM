//
//  LoginPage.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import Action
import RxCocoa
import RxSwift
import DDMvvm

class LoginPage: Page<LoginPageViewModel> {

    var messageLbl: UILabel!
    
    override func initialize() {
        super.initialize()
        
        messageLbl = UILabel()
        messageLbl.text = "Login Page".localization
        messageLbl.textAlignment = .center
        messageLbl.font = Font.system.normal(withSize: 25)
        view.addSubview(messageLbl)
        messageLbl.autoCenterInSuperview()
        
        hideNavigationBar()
    }
    
    override func bindViewAndViewModel() {
        super.bindViewAndViewModel()
    }
}

class LoginPageViewModel: ViewModel<Model> {
    
    override func react() {
        super.react()
    }
}
