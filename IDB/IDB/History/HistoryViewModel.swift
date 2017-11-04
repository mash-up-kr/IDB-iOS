//
//  HistoryViewModel.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation

class HistoryViewModel {

    var min = 0
    var type = 0 // 0 : today, 1: Weelky  2: Monthly
    var items: [History] = []
    weak var view: HistoryViewModelDelegate? = nil


    func loadHistoryList() {

        APIManager.request(apiRequest: HistoryAPI.load) { (result) in
            switch result {
            case .success(let response):

                for i in 0...10 {
                    let item1 = response.dictionaryValue["items"]!.arrayValue[i]

                    var historyItem = History()
                    historyItem.title = item1.dictionaryValue["title"]!.stringValue
                    historyItem.imageUrl = item1.dictionaryValue["thumnail_src"]!.stringValue
                    historyItem.speakerName = item1.dictionaryValue["speaker"]!.stringValue
                    historyItem.timeDuration = item1.dictionaryValue["time_duration"]!.stringValue

                    self.items.append(historyItem)
                }

                print(response.dictionaryValue["items"]!.arrayValue[0])

                self.view?.loadSuccess()
            case .failure(let err):
                self.view?.loadFaliure(error: err)
            }
        }

    }

}
