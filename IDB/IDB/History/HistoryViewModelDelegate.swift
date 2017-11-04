//
//  HistoryViewModelDelegate.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation

protocol HistoryViewModelDelegate: class {

    func loadSuccess()
    func loadFaliure(error: Error)

}
