//
//  AlamofireRequest.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 4..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequest {

    fileprivate static var sessionManager: Alamofire.SessionManager {
        let sessionManager = Alamofire.SessionManager.default
        return sessionManager
    }

    static func request(apiRequest: API, successHandler:  @escaping (Any) -> (Void), failureHandler: @escaping (Error) -> (Void)) {
        sessionManager.request("\(apiRequest.host)\(apiRequest.path)",
            method: apiRequest.method,
            parameters: apiRequest.parameters,
            headers: apiRequest.headers
            ).responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(let err):
                    failureHandler(err)
                }

        }
    }
}

