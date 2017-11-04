//
//  TimePickerView.swift
//  IDB
//
//  Created by Daeyun Ethan Kim on 05/11/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

// MARK: - TimePickerViewDelegater
protocol TimePickerViewDelegate: class {
    func setTenthDigit(tenthDigit: Int)
    func setOnesDigit(onesDigit: Int)
}


// MARK: - TimePickerView
class TimePickerView: UIView {

    // MARK: Properties
    weak var containerView: UIView?
    
    private let pickerViewRows = 10_000
    private let firstPickerDataSource = Array(0...5)
    private let secondPickerDataSource = Array(0...9)
    var tenthDigit = 0
    var onesDigit = 0
    
    weak var delegate: TimePickerViewDelegate?
    
    // MARK: Outlets
    @IBOutlet weak var timePickerView: UIPickerView?
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitialization()
    }
    
    func commonInitialization() {
        containerView = Bundle.main.loadNibNamed("TimePickerView", owner: self, options: nil)?.first as? UIView
        
        guard let containerView = containerView else {
            print("Error: MainNavigationView - commonInitialization => containerView doesn't exist")
            return
        }
        
        containerView.frame = bounds
        
        addSubview(containerView)
        
        timePickerView?.dataSource = self
        timePickerView?.delegate = self
        
        initPickerView()
    }
    
    func initPickerView() {
        let firstPickerViewMiddle = ((pickerViewRows / firstPickerDataSource.count) / 2) * firstPickerDataSource.count
        let secondPickerViewMiddle = ((pickerViewRows / secondPickerDataSource.count) / 2) * secondPickerDataSource.count
        
        let initialValue = 0
        if let row = rowForValue(value: initialValue, pickerViewMiddle: firstPickerViewMiddle) {
            timePickerView?.selectRow(row, inComponent: 0, animated: false)
        }
        
        if let row = rowForValue(value: initialValue, pickerViewMiddle: secondPickerViewMiddle) {
            timePickerView?.selectRow(row, inComponent: 1, animated: false)
        }
        
        timePickerView?.subviews[1].isHidden = true
        timePickerView?.subviews[2].isHidden = true
    }
}


// MARK: - TimePickerView: UIPickerViewDataSource, UIPickerViewDelegate
extension TimePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func rowForValue(value: Int, pickerViewMiddle: Int) -> Int? {
        //        if let valueIndex = find(pickerViewData, value) {
        return pickerViewMiddle + value
        //        }
        //        return nil
    }
    
    func valueForRow(row: Int, component: Int) -> Int {
        switch component {
        case 0:
            return firstPickerDataSource[row % firstPickerDataSource.count]
        case 1:
            return secondPickerDataSource[row % secondPickerDataSource.count]
        default:
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewRows
    }
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return "\(valueForRow(row: row, component: component))"
    //    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 150
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Futura-CondensedMedium", size: 111)
        label.text = "\(valueForRow(row: row, component: component))"
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstPickerViewMiddle = ((pickerViewRows / firstPickerDataSource.count) / 2) * firstPickerDataSource.count
        let secondPickerViewMiddle = ((pickerViewRows / secondPickerDataSource.count) / 2) * secondPickerDataSource.count
        
        switch component {
        case 0:
            let newRow = firstPickerViewMiddle + (row % firstPickerDataSource.count) - 4998
            //            pickerView.selectRow(newRow, inComponent: 0, animated: false)
//            print("Resetting row to \(newRow * 10)")
            tenthDigit = newRow * 10
            delegate?.setTenthDigit(tenthDigit: tenthDigit)
            
        case 1:
            let newRow = secondPickerViewMiddle + (row % secondPickerDataSource.count) - 5000
            //            pickerView.selectRow(newRow, inComponent: 0, animated: false)
//            print("Resetting row to \(newRow)")
            onesDigit = newRow
            delegate?.setOnesDigit(onesDigit: onesDigit)
            
        default:
            print("error")
        }
    }
}
