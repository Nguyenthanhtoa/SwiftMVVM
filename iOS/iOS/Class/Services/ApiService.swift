//
//  ApiService.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import DDMvvm

class ApiService: NetworkService {
    
    init() {
        super.init(baseUrl: endpoint)
    }
    
    // MARK: - GET methods
    
    func get<T: Mappable>(_ path: String,
                          params: [String: Any]? = nil,
                          parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                          additionalHeaders: HTTPHeaders? = nil) -> Observable<T> {
        return request(path, method: .get, params: params, parameterEncoding: encoding, additionalHeaders: additionalHeaders)
    }
    
    func get<T: Mappable>(_ path: String,
                          params: [String: Any]? = nil,
                          parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                          additionalHeaders: HTTPHeaders? = nil) -> Observable<[T]> {
        return request(path, method: .get, params: params, additionalHeaders: additionalHeaders)
    }
    
    // MARK: - POST methods
    
    func post<T: Mappable>(_ path: String,
                           params: [String: Any]? = nil,
                           parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                           additionalHeaders: HTTPHeaders? = nil) -> Observable<T> {
        return request(path, method: .post, params: params, additionalHeaders: additionalHeaders)
    }
    
    func post<T: Mappable>(_ path: String,
                           params: [String: Any]? = nil,
                           parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                           additionalHeaders: HTTPHeaders? = nil) -> Observable<[T]> {
        return request(path, method: .post, params: params, additionalHeaders: additionalHeaders)
    }
    
    
    // MARK: - PUT methods
    
    func put<T: Mappable>(_ path: String,
                           params: [String: Any]? = nil,
                           parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                           additionalHeaders: HTTPHeaders? = nil) -> Observable<T> {
        return request(path, method: .put, params: params, additionalHeaders: additionalHeaders)
    }
    
    func put<T: Mappable>(_ path: String,
                           params: [String: Any]? = nil,
                           parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                           additionalHeaders: HTTPHeaders? = nil) -> Observable<[T]> {
        return request(path, method: .put, params: params, additionalHeaders: additionalHeaders)
    }
    
    // MARK: - DELETE methods
    
    func delete<T: Mappable>(_ path: String,
                             params: [String: Any]? = nil,
                             parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                             additionalHeaders: HTTPHeaders? = nil) -> Observable<T> {
        return request(path, method: .delete, params: params, additionalHeaders: additionalHeaders)
    }
    
    func delete<T: Mappable>(_ path: String,
                             params: [String: Any]? = nil,
                             parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                             additionalHeaders: HTTPHeaders? = nil) -> Observable<[T]> {
        return request(path, method: .delete, params: params, additionalHeaders: additionalHeaders)
    }
    
    // MARK: - Private methods
    
    private func request<T: Mappable>(_ path: String,
                                      method: HTTPMethod,
                                      params: [String: Any]? = nil,
                                      parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                                      additionalHeaders: HTTPHeaders? = nil) -> Observable<T> {
        return callRequest(path, method: method, params: params, parameterEncoding: encoding, additionalHeaders: additionalHeaders)
            .asObservable()
            .map { responseString in
                
                print(responseString)
                
                if let error = self.validateServerError(responseString) {
                    throw error
                }
                
                if let model = Mapper<T>().map(JSONString: responseString) {
                    return model
                }
                
                throw NSError.mapperError
        }
    }
    
    private func request<T: Mappable>(_ path: String,
                                      method: HTTPMethod,
                                      params: [String: Any]? = nil,
                                      parameterEncoding encoding: ParameterEncoding = JSONEncoding.default,
                                      additionalHeaders: HTTPHeaders? = nil) -> Observable<[T]> {
        
        print("CALL API ===> " + path)
        
        return callRequest(path, method: method, params: params, parameterEncoding: encoding, additionalHeaders: additionalHeaders)
            .asObservable()
            .map { responseString in
                if let error = self.validateServerError(responseString) {
                    throw error
                }
                
                if let models = Mapper<T>().mapArray(JSONString: responseString) {
                    return models
                }
                
                throw NSError.mapperError
        }
    }
    
    private func validateServerError(_ jsonString: String) -> Error? {
        if let serverErrorModel = Mapper<ServerErrorModel>().map(JSONString: jsonString),
            serverErrorModel.resultCode != StatusCode.success {
            return serverErrorModel
        }
        
        return nil
    }
}



