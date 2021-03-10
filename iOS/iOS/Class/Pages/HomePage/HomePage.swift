//
//  HomeView.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import DDMvvm

class HomePage: Page<HomePageViewModel> {
    
    var contentView: HomeContentView!

    override func initialize() {
        super.initialize()
        
        contentView = UIView.loadFrom(nibNamed: "HomeContentView")
        view.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }
    
    override func bindViewAndViewModel() {
        super.bindViewAndViewModel()
    }
  
    override func destroy() {
        super.destroy()
       
    }

}

class HomePageViewModel: ViewModel<Model> {
    
    override func react() {
        super.react()
    }
  
}
