//
//  HomeViewController.swift
//  IDB
//
//  Created by 강경완 on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController{


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HistoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HistoryViewModel()
        viewModel.view = self

        tableView.delegate = self
        tableView.dataSource = self

        imageView.layer.shadowColor = UIColor.purple.cgColor
        imageView.layer.shadowRadius = 1
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)

        viewModel.loadHistoryList()
//        imageView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 10, height: (imageView.superview?.bounds.height)!)).cgPath
    }


}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "historyCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! HistoryViewCell
        let historyModel = viewModel.items[indexPath.row]

        if cell == nil {
            cell = HistoryViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }

        if let imageData: Data = try? Data(contentsOf: URL(string: historyModel.imageUrl)!){
            cell.thumnailImageView.image = UIImage(data: imageData)
        }

        cell.titleLabel.text = historyModel.title
        cell.timeLabel.text = historyModel.timeDuration
        cell.speakerLabel.text = historyModel.speakerName

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension HistoryViewController: HistoryViewModelDelegate {
    func loadSuccess() {
        tableView.reloadData()
    }

    func loadFaliure(error: Error) {
        print(error.localizedDescription)
    }


    
}

