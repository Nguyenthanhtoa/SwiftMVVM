//
//  DataManager.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire
import DDMvvm

class DataManager {
    
    static let shared: DataManager = DataManager()
    
    private var disposeBag: DisposeBag! = DisposeBag()
    let rxApplicationState = BehaviorRelay<ApplicationState>(value: .none)
    let rxConnected = BehaviorRelay(value: true)
    
    // Services
    private let storageService: IStorageService = dependencyManager.getService()
    
    // Variables
    let rxUser = BehaviorRelay<UserModel>(value: UserModel())
    
    func initialize() {
        startNetworkReachabilityObserver()
        
        react()
    }
    
    func react() {
        rxConnected
            .distinctUntilChanged()
            .subscribe(onNext: loadInitial) => disposeBag
        
        rxUser
            .filter { $0.isValid }
            .subscribe(onNext: storeUser) => disposeBag
    }

}

// Extensions for data manager to load data

extension DataManager {
    
    func loadInitial(_ isConnected: Bool) {
        loadUser()
    }
    
    func loadUser() {
        if let user: UserModel = storageService.loadModel(forKey: StorageKey.kUser) {
            rxUser.accept(user)
        } else {
            initUser()
        }
    }
    
    func initUser() {
        if !rxUser.value.isValid {
            let usr = UserModel(name: "", password: "")
            rxUser.accept(usr)
        }
    }
   
}

// Extensions for data manager to STORE data

extension DataManager {
    
    func storeUser(user: UserModel) {
        storageService.saveModel(rxUser.value, forKey: StorageKey.kUser)
    }
    
}


//MARK: Utils for DataManager
extension DataManager {
    
    fileprivate func startNetworkReachabilityObserver() {
        let manager = Alamofire.NetworkReachabilityManager()
        manager?.startListening { status in
            self.rxConnected.accept(status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular))
            print("rxConnected: \(self.rxConnected.value)")
        }
    }
    
    func makeKey(_ key: String, _ isComplex: Bool = true) -> String {
        return key + "_" + rxUser.value.name
    }
    
}


