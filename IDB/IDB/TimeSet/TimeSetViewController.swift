//
//  TimeSetViewController.swift
//  IDB
//
//  Created by Daeyun Ethan Kim on 04/11/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

let kFavoritTimeCollectionViewCellID = "FavoritTimeCollectionViewCell"
let kFavoritTimeUserDefaultKey = "kFavoritTime"

// MARK: - TimeSetViewController
class TimeSetViewController: UIViewController {

    // MARK: Properties
    
    var tenthDigit = 0
    var onesDigit = 0
    
    var favoritTime = [Int]()
    
    // MARK: Outlets
    @IBOutlet weak var addFavoritCollectionView: UICollectionView?
    @IBOutlet weak var timePickerView: TimePickerView?
    @IBOutlet weak var submitButton: UIButton?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initNibs()
        initTimePickerView()
        initCollectionView()
        initSubmitButton()
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
    
    func initSubmitButton() {
        submitButton?.backgroundColor = .clear
        
        guard let height = submitButton?.bounds.size.height else {
            print("Error - ")
            return
        }
        
        let color = UIColor(red: 0.35, green: 0.20, blue: 0.204, alpha: 1.0)
        submitButton?.setTitleColor(color, for: .normal)
        submitButton?.layer.cornerRadius = height / 2
        submitButton?.layer.borderWidth = 2
        submitButton?.layer.borderColor = color.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setFavoritTime()
    }
    
    func setFavoritTime() {
//        favoritTime = [Int]()
        guard let favoritTime = UserDefaults.standard.value(forKey: kFavoritTimeUserDefaultKey) as? [Int] else {
            print("없다")
            return
        }
        
        self.favoritTime = favoritTime
        print(favoritTime.count)
        
        addFavoritCollectionView?.reloadData()
    }
    
    
    // MARK: Actions
    @IBAction func addFavoritTime(_ sender: Any) {
        let addFavoritTimeStoryboard = UIStoryboard(name: "AddFavoritTime", bundle: nil)
        
        guard let addFavoritTimeVC = addFavoritTimeStoryboard.instantiateViewController(withIdentifier: "AddFavoritTimeViewController") as? AddFavoritTimeViewController else {
            print("Error - TimeSetViewController_addFavoritTime: addFavoritTimeVC를 생성 할 수 없습니다.")
            return
        }
        
        present(addFavoritTimeVC, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let minutes = tenthDigit + onesDigit
        print(minutes)
        UserDefaults.standard.set(minutes, forKey: "kMinutes")
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - TimeSetViewController: UICollectionViewDataSource, UICollectionViewDelegate
extension TimeSetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count : \(favoritTime.count)")
        return 1 + favoritTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case favoritTime.count:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFavoritTimeButton", for: indexPath)
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFavoritTimeCollectionViewCellID, for: indexPath) as? FavoritTimeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case favoritTime.count:
            return
        default:
            let minutes = favoritTime[indexPath.row]
            print(minutes)
            UserDefaults.standard.set(minutes, forKey: "kMinutes")
            dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - TimeSetViewController: TimePickerViewDelegate
extension TimeSetViewController: TimePickerViewDelegate {
    func setTenthDigit(tenthDigit: Int) {
        self.tenthDigit = tenthDigit
        
        print(self.tenthDigit)
    }
    
    func setOnesDigit(onesDigit: Int) {
        self.onesDigit = onesDigit
        
        print(self.onesDigit)
    }
}
