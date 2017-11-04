//
//  TabViewController.swift
//  IDB
//
//  Created by Daeyun Ethan Kim on 04/11/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit
import Alamofire

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let params: [String: String] = [:]

        APIManager.request(apiRequest: TestAPI.test(params: params), responseHandler: { response in
            switch response {
            case .success(let jsonResponse):
                print(jsonResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
