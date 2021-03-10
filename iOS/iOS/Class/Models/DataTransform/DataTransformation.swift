//
//  DataTransformation.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import ObjectMapper
import DDMvvm
import UIKit

class MediaURLTransform: TransformType {
    typealias Object = URL
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            if value.hasPrefix("http://") || value.hasPrefix("https://") {
                return URL(string: value)
            } else {
                let urlString = "\(environment.rawValue)\(value)"
                return URL(string: urlString)
            }
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        return value?.absoluteString
    }
}

class MediaURLsTransform: TransformType {
    typealias Object = [URL]
    typealias JSON = [String]
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            return value.compactMap { v -> URL? in
                if v.hasPrefix("http://") || v.hasPrefix("https://") {
                    return URL(string: v)
                } else {
                    let urlString = "\(environment.rawValue)\(v)"
                    return URL(string: urlString)
                }
            }
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        return value?.compactMap { $0.absoluteString }
    }
}

// MARK: ISO Date
class ISODateTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    internal func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            let isoDate = Date(fromString: dateString, format: .custom("yyyy-MM-dd'T'HH:mm:ss"))
            let normalDate = Date(fromString: dateString, format: .isoDate)
            return isoDate ?? normalDate
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.asString("yyyy-mm-ddThh:mm:ss")
        }
        return nil
    }
}

// MARK: StandardDateTransform
class StandardDateTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    internal func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            let isoDate = Date(fromString: dateString, format: .custom("yyyy-MM-dd HH:mm:ss"))
            let normalDate = Date(fromString: dateString, format: .isoDate)
            return isoDate ?? normalDate
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.asString("yyyy-mm-ddThh:mm:ss")
        }
        return nil
    }
}
