//
//  PListService.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import ObjectMapper
import DDMvvm

protocol IPlistService {
    
    func loadArray<T: Model>(resourceName: String) -> [T]
    func loadArray<T: Model>(resourceName: String, type: String) -> [T]
    
}

class PlistService: IPlistService {

    func loadArray<T: Model>(resourceName: String) -> [T] {
        if let path = Bundle.main.path(forResource: resourceName, ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String : Any]] {
                return Mapper<T>().mapArray(JSONArray: array)
            }
        }
        return []
    }
    
    func loadArray<T: Model>(resourceName: String, type: String) -> [T] {
        if let path = Bundle.main.path(forResource: resourceName, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    return Mapper<T>().mapArray(JSONArray: [jsonResult])
                }
            } catch {
                return []
            }
        }
        return []
    }
    
}
