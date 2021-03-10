//
//  User.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import DDMvvm

class UserModel: Model {
    
    var name = ""
    var password = ""
    
    var isValid: Bool {
        return !name.isEmpty && !password.isEmpty
    }
    
    convenience init() {
        self.init(JSON: [String: Any]())!
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        password <- map["password"]
    }
    
    convenience init(name: String, password: String) {
        self.init(JSON: ["name": name, "password": password])!
    }
    
}













