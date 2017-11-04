//
//  ContentAPI.swift
//  IDB
//
//  Created by snow on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import Alamofire

enum ContentAPI: API {
    
    case home(params: [String: String])
    
    var method: HTTPMethod {
        switch self {
        case .home:
            return .get
        }
    }
    
    var path: String {
        return "/home"
    }
    
    var parameters: [String : Any] {
        switch self {
        case .home(let params):
            return params
        }
    }
    
    var headers: [String : String] {
        return defaultHeaders
    }
    
}
