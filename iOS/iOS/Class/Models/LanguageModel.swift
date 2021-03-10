//
//  LanguageModel.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import ObjectMapper
import DDMvvm

class LanguageModel: Model {
    
    var code: LanguageCode = .ja
    var name = ""
    
    static var defaultLanguage: LanguageModel {
        return LanguageModel(withCode: .ja)
    }
    
    convenience init(withCode code: LanguageCode) {
        self.init(JSON: [String : Any]())!
        self.code = code
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LanguageModel else { return false }
        return object.code == code
    }
    
    override func mapping(map: Map) {
        code <- (map["code"], EnumTransform<LanguageCode>())
        name <- map["name"]
    }
}









