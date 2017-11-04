//
//  TestAPI.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 4..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import Alamofire

enum TestAPI: API {

    case test(params: [String: String])

    var method: HTTPMethod {
        switch self {
        case .test:
            return .get
        }
    }

    var path: String {
        return "/test"
    }

    var parameters: [String : Any] {
        switch self {
        case .test(let params):
            return params
        }
    }

    var headers: [String : String] {
        return defaultHeaders
    }

}
