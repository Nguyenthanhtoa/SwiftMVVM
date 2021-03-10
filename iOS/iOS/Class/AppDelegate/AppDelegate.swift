//
//  AppDelegate.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DDMvvm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerServices()
        styleAppearance()
        
        // Initialize dataManager
        dataManager.initialize()
        
        let rootPage = NavigationPage(rootViewController: LoginPage(viewModel: LoginPageViewModel()))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootPage
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        dataManager.rxApplicationState.accept(.resignActive)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        dataManager.rxApplicationState.accept(.didEnterBackground)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        dataManager.rxApplicationState.accept(.willEnterForeground)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        dataManager.rxApplicationState.accept(.didBecomeActive)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        dataManager.rxApplicationState.accept(.willTerminate)
    }
    
    // MARK: - Private
    
    private func styleAppearance() {
        // add font helvetica
        Font.add("helvetica", factory: Helvetica())
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.setBackgroundImage(.from(color: .white), for: .default)
        navBarAppearance.tintColor = .black
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: Font.system.normal(withSize: 18)
        ]
        navBarAppearance.shadowImage = .from(color: .clear)
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .white
        
        // IQKeyboardManager configs
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enable = true
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.enableAutoToolbar = false
    }
}

extension AppDelegate {
    
    func registerServices() {
        dependencyManager.registerDefaults()
        
        let plistFactory = Factory<IPlistService> {
            return PlistService()
        }
        
        let hubFactory = Factory<IHudService> {
            return HudService()
        }
        
        let loginFactory = Factory<ILoginService> {
            return LoginService()
        }
        
        dependencyManager.registerService(plistFactory)
        dependencyManager.registerService(hubFactory)
        dependencyManager.registerService(loginFactory)
    }
}














