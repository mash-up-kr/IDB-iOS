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
    
    case home(path: String)
    
    var method: HTTPMethod {
        switch self {
        case .home:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .home(let path):
            if path == "TODAY" || path == "ENTERTAIN" || path == "TECH"  {
                return "/home"
            } else {
                return "/home/\(path)"
            }
        }

    }
    
    var parameters: [String : Any] {
        switch self {
        case .home:
            return [:]
        }
    }
    
    var headers: [String : String] {
        return defaultHeaders
    }
    
}
