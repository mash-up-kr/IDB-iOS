//
//  HistoryViewCell.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

class HistoryViewCell: UITableViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    
    let cellHeight = 150

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
