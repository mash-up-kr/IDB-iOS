//
//  AddFavoritTimeViewController.swift
//  IDB
//
//  Created by Daeyun Ethan Kim on 05/11/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

// MARK: - AddFavoritTimeViewController
class AddFavoritTimeViewController: UIViewController {

    // MARK: Properties
    let icons = [UIImage(named: "home"), UIImage(named: "home"), UIImage(named: "home"), UIImage(named: "home"), UIImage(named: "home")]
    
    var tenthDigit = 0
    var onesDigit = 0
    
    // MARK: Outlets
    @IBOutlet weak var addFavoritCollectionView: UICollectionView?
    @IBOutlet weak var timePickerView: TimePickerView?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNibs()
        initTimePickerView()
        initCollectionView()
    }
    
    func initNibs() {
        let addFavoritTimeNib = UINib(nibName: kFavoritTimeCollectionViewCellID, bundle: nil)
        addFavoritCollectionView?.register(addFavoritTimeNib, forCellWithReuseIdentifier: kFavoritTimeCollectionViewCellID)
        
    }
    
    func initTimePickerView() {
        timePickerView?.delegate = self
    }
    
    func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 100.0, height: 100.0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        
        addFavoritCollectionView?.dataSource = self
        addFavoritCollectionView?.delegate = self
        addFavoritCollectionView?.alwaysBounceHorizontal = true
        addFavoritCollectionView?.collectionViewLayout = flowLayout
        addFavoritCollectionView?.showsHorizontalScrollIndicator = false
        addFavoritCollectionView?.isPagingEnabled = true
    }
    
    // MARK: Actions
    @IBAction func saveButtonAction(_ sender: Any) {
        guard var favoritTime = UserDefaults.standard.value(forKey: kFavoritTimeUserDefaultKey) as? [Int] else {
            let minutes = tenthDigit * 10 + onesDigit
            let favoritTime = [minutes]
            UserDefaults.standard.set(favoritTime, forKey: kFavoritTimeUserDefaultKey)
            return
        }
        UserDefaults.standard.removeObject(forKey: kFavoritTimeUserDefaultKey)
        
        let minutes = tenthDigit + onesDigit
        favoritTime.append(minutes)
        UserDefaults.standard.set(favoritTime, forKey: kFavoritTimeUserDefaultKey)
        
        print(favoritTime)
        dismiss(animated: true, completion: nil)
    }
}


// MARK: AddFavoritTimeViewController: UICollectionViewDataSource, UICollectionViewDelegate
extension AddFavoritTimeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFavoritTimeCollectionViewCellID, for: indexPath) as? FavoritTimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


// MARK: - AddFavoritTimeViewController: TimePickerViewDelegate
extension AddFavoritTimeViewController: TimePickerViewDelegate {
    func setTenthDigit(tenthDigit: Int) {
        self.tenthDigit = tenthDigit
        
        print(self.tenthDigit)
    }
    
    func setOnesDigit(onesDigit: Int) {
        self.onesDigit = onesDigit
        
        print(self.onesDigit)
    }
}
