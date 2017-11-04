//
//  ContentViewController.swift
//  IDB
//
//  Created by snow on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import SwiftyJSON

class ContentViewController: UIViewController, IndicatorInfoProvider {
    
    var indicatorInfo = IndicatorInfo(title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.request(apiRequest: ContentAPI.home(params: [:]), responseHandler: { response in
            switch response {
            case .success(let jsonResponse):
                print(jsonResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
    
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentVideoCell", for: indexPath) as! ContentVideoCell
        cell.viewData = ContentVideoViewData()
        return cell
    }
    
}
