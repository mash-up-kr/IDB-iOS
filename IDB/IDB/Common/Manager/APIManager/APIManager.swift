//
//  APIManager.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 4..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIManager {

    enum response {
        case success(jsonResponse: JSON)
        case failure(error: Error)
    }

    static func request(apiRequest: API, responseHandler: @escaping (response) -> ()) {
        AlamofireRequest.request(apiRequest: apiRequest, successHandler: { result in
            responseHandler(response.success(jsonResponse: JSON(result)))
        }, failureHandler: { error in
            responseHandler(response.failure(error: error))
        })
    }


    static func bbb (error: Error) {

    }



}

