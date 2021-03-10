//
//  ServerErrorModel.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import DDMvvm
import ObjectMapper

class ServerErrorModel: BaseReponseModel, Error {
    
    var localizedDescription: String {
        switch resultCode {
        case .serverError: return "server_error".localization
        case .parameterError: return "parameter_error".localization
        default: return "authentication_error".localization
        }
    }
    
}


