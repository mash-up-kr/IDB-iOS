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
    
    @IBOutlet weak var tableView: UITableView!
    
    var indicatorInfo = IndicatorInfo(title: "")
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistoryList()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
    
    func loadHistoryList() {
        
        APIManager.request(apiRequest: HistoryAPI.load) { [weak self] result in
            switch result {
            case .success(let response):
                guard let cotentCount = response.dictionaryValue["items"]?.array?.count else {
                    return
                }
                for i in 0..<cotentCount {
                    let item = response.dictionaryValue["items"]!.arrayValue[i]
                    
                    let contentItem = Content()
                    contentItem.title = item.dictionaryValue["title"]!.stringValue
                    contentItem.imageUrl = item.dictionaryValue["thumnail_src"]!.stringValue
                    contentItem.linkUrl = item.dictionaryValue["link_url"]!.stringValue
                    contentItem.speakerName = item.dictionaryValue["speaker"]!.stringValue
                    contentItem.timeDuration = item.dictionaryValue["time_duration"]!.stringValue
                    contentItem.rated = item.dictionaryValue["rated"]?.arrayObject as! [String]
                    
                    self?.contents.append(contentItem)
                }
                self?.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
        
    }
    
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentVideoCell", for: indexPath) as! ContentVideoCell
        let content = contents[indexPath.row]
        let ratedCount = content.rated.count
        print(">>\(ratedCount)")
        
        cell.titleLabel.text = content.title
        cell.descriptionLabel.text = content.speakerName
        cell.timeLabel.text = content.timeDuration
        
        if let imageData: Data = try? Data(contentsOf: URL(string: content.imageUrl)!){
            cell.thumbnailImageView.image = UIImage(data: imageData)
        }
        
        if ratedCount > 0 {
            cell.firstCategoryView.isHidden = false
            cell.firstCategoryView.layer.cornerRadius = cell.firstCategoryView.frame.height / 2
            cell.firstCategoryLabel.text = "#" + content.rated[0]
        }
        if ratedCount > 1 {
            cell.secondCategoryView.isHidden = false
            cell.secondCategoryView.layer.cornerRadius = cell.secondCategoryView.frame.height / 2
            cell.secondCategoryLabel.text = "#" + content.rated[1]
        }
        if ratedCount > 2 {
            cell.thirdCategoryView.isHidden = false
            cell.thirdCategoryView.layer.cornerRadius = cell.thirdCategoryView.frame.height / 2
            cell.thirdCategoryLabel.text = "#" + content.rated[2]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlString = contents[indexPath.row].linkUrl
        UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
    }
    
}
