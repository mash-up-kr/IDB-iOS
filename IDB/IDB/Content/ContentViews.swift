//
//  ContentViews.swift
//  IDB
//
//  Created by snow on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

class ContentVideoCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var firstCategoryView: UIView!
    @IBOutlet weak var secondCategoryView: UIView!
    @IBOutlet weak var thirdCategoryView: UIView!
    @IBOutlet weak var firstCategoryLabel: UILabel!
    @IBOutlet weak var secondCategoryLabel: UILabel!
    @IBOutlet weak var thirdCategoryLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewData: ContentVideoViewData? {
        didSet {
            firstCategoryView.layer.cornerRadius = firstCategoryView.frame.height / 2
            secondCategoryView.layer.cornerRadius = secondCategoryView.frame.height / 2
            thirdCategoryView.layer.cornerRadius = thirdCategoryView.frame.height / 2
        }
    }
    
}
