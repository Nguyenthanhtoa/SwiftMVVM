//
//  CommonModel.swift
//  iOS
//
//  Created by ThanhToa on 3/4/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import DDMvvm

class BaseReponseModel: Model {
    
    var resultCode: StatusCode = .success
    
    convenience init() {
        self.init(JSON: [String: Any]())!
    }
    
    override func mapping(map: Map) {
        resultCode <- (map["result_code"], EnumTransform<StatusCode>())
    }
    
}


class CommonModel: Model {

    var title = ""
    var value = ""
    
    convenience init() {
        self.init(JSON: [String: Any]())!
    }
    
    override func mapping(map: Map) {
        title <- map["title"]
        value <- map["value"]
    }
    
    convenience init(title: String, value: String) {
        self.init(JSON: ["title" : title, "value" : value])!
    }
    
}
















