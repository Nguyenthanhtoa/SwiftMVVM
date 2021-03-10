//
//  Global.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//


import Foundation
import UIKit
import DDMvvm

let scheduler = Scheduler.shared
let dataManager = DataManager.shared
let dependencyManager = DependencyManager.shared
let localizationManager = LocalizationManager.shared

let screenSize = UIScreen.main.bounds
let isPad = UIDevice.current.userInterfaceIdiom == .pad
let isPhone = UIDevice.current.userInterfaceIdiom == .phone

// MARK: - Global funcs

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
        execute: closure
    )
}

var hasSafeArea: Bool {
    if #available(iOS 11.0,  *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    
    return false
}

struct StorageKey {
    
    static let kLanguage = "kLanguage"
    static let kUser = "kUser"

}

struct AppConfigs {
    
    static let defaultPassword = "password"

}

// MARK: - App icons

struct Image {
    
    static func make(fromName imageNamed: String) -> UIImage? {
        return UIImage(named: imageNamed)
    }
    
    static func make(fromHex hex: String) -> UIImage {
        return UIImage.from(color: .fromHex(hex))
    }
    
    static let subscribeIcon = make(fromName: "icon_subscribed")
}

// MARK: - Enums

enum ComponentViewPosition {
    case top(CGFloat), left(CGFloat), bottom(CGFloat), right(CGFloat), center
}

enum ViewState {
    case none, willAppear, didAppear, willDisappear, didDisappear
}

enum ApplicationState {
    case none, resignActive, didEnterBackground, willEnterForeground, didBecomeActive, willTerminate
}

enum LanguageCode: String {
    case none = "none" // using phone language
    case en = "en"
    case ja = "ja"
}

enum Environment: String {
    case development = "development"
    case production = "production"
}

struct Helvetica: FontFactory {
    
    var normalName: String {
        return "Helvetica"
    }
    
    var lightName: String {
        return "Helvetica-Light"
    }
    
    var boldName: String {
        return "Helvetica-Bold"
    }
}

// MARK: - Font factory

var helvetica: FontFactory {
    return Font.get("helvetica")
}

// MARK: - API environment

let environment: Environment = .development

let apiComponent = "api/lodge"

let endpoint = "\(environment.rawValue)/\(apiComponent)"











