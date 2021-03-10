//
//  LoginService.swift
//  iOS
//
//  Created by ToaNT1 on 2/19/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//

import Foundation
import RxSwift

protocol ILoginService {
    func loginWithUserId(_ userId: String, password: String) -> Observable<UserModel>
}

class MockLoginService: ILoginService {
    
    private let mockUsers: [[String: String]] = {
        if let filepath = Bundle.main.path(forResource: "MockUsers", ofType: "plist") {
            return NSArray(contentsOfFile: filepath) as! [[String: String]]
        }
        return [["":""]]
    }()
    
    func loginWithUserId(_ userId: String, password: String) -> Observable<UserModel> {
        return Observable.just(())
            .delay(.seconds(3), scheduler: scheduler.mainScheduler)
            .map {
                if let _ = self.mockUsers.filter({ $0["userId"]?.uppercased() == userId.uppercased() && $0["pass"] == password }).first {
                    let user = UserModel()
                    return user
                } else {
                    throw NSError.mapperError
                }
            }
    }
}

class LoginService: ApiService, ILoginService {
    
    func loginWithUserId(_ email: String, password: String) -> Observable<UserModel> {
        return post("login", params: ["email": email, "password": password])
    }
}


















