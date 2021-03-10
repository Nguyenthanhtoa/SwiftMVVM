//
//  LocalizationManager.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DDMvvm

class LocalizationManager {
    
    // MARK: - Singleton method
    
    static let shared = LocalizationManager()
    
    // MARK: - Private properties
    
    private let storageService: IStorageService = dependencyManager.getService()
    private var localizationDict: [String: String]?
    private let rxCurrentLanguage = BehaviorRelay<LanguageModel>(value: .defaultLanguage)
    
    // MARK: - Public properties
    
    var languageChanged: Observable<LanguageModel> {
        return rxCurrentLanguage.asObservable().distinctUntilChanged()
    }
    
    var currentLanguage: LanguageModel {
        return rxCurrentLanguage.value
    }
    
    // MARK: - Init method
    
    init() {
        // set language saved on local or default language
        let languageSaved = storageService.loadModel(forKey: StorageKey.kLanguage) as? LanguageModel ?? currentLanguage
        setLanguage(languageSaved)
    }
    
    // MARK: - Private instance methods
    
    @discardableResult
    private func loadDictionaryForLanguage(_ newLanguage: LanguageModel) -> Bool {
        if let cls = object_getClass(self),
            let path = Bundle(for: cls).url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: newLanguage.code.rawValue)?.path {
            if FileManager.default.fileExists(atPath: path),
                let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                rxCurrentLanguage.accept(newLanguage)
                localizationDict = dict
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Public instance methods
    
    func localizedStringForKey(_ key: String) -> String {
        if let dict = localizationDict {
            if let localizedString = dict[key] {
                return localizedString
            } else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    func setLanguage(_ newLanguage: LanguageModel) {
        switch newLanguage.code {
        case .none:
            rxCurrentLanguage.accept(newLanguage)
            localizationDict = nil
            
            storageService.remove(StorageKey.kLanguage)
            
        default:
            if loadDictionaryForLanguage(newLanguage) {
                storageService.saveModel(currentLanguage, forKey: StorageKey.kLanguage)
            }
        }
    }
}
