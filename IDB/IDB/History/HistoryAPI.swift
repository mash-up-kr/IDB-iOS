//
//  HistoryAPI.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import Alamofire

enum HistoryAPI: API {
    case load

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/home/Design"
    }

    var parameters: [String : Any] {
        return [:]
    }

    var headers: [String : String] {
        return defaultHeaders
    }




}
