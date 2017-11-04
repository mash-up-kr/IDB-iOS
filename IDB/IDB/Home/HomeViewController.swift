//
//  HomeViewController.swift
//  IDB
//
//  Created by snow on 2017. 11. 5..
//  Copyright © 2017년 Daeyun Ethan Kim. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        setSetting()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, _, changeCurrentIndex: Bool, _) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .black
        }
        
        super.viewDidLoad()
    }
    
    fileprivate func setSetting() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .black
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1Storyboard = UIStoryboard(name: "Content", bundle: nil)
        let child1ViewController = child1Storyboard.instantiateInitialViewController() as!  ContentViewController
        child1ViewController.indicatorInfo.title = "추천"
        
        let child2Storyboard = UIStoryboard(name: "Content", bundle: nil)
        let child2ViewController = child2Storyboard.instantiateInitialViewController() as!  ContentViewController
        child2ViewController.indicatorInfo.title = "디자인"
        
        return [child1ViewController, child2ViewController]
    }
    
}
