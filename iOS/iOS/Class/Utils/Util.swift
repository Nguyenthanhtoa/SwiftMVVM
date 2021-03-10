//
//  Util.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import UIKit

struct Util {
    
    static var appVersion: String {
        let key = environment == .production ? "CFBundleShortVersionString" : "CFBundleVersion"
        let version = Bundle.main.infoDictionary?[key] as? String
        return version ?? ""
    }
 
}
