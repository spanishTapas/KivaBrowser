//
//  CriteriaPicker.swift
//  KivaBrowser
//
//  Created by wanming zhang on 9/4/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class CriteriaPicker: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    var selectedCriteriaStr: String?
    var pickerTag: String?
    
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var sectorPicker: UIPickerView!
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var regionPicker: UIPickerView!
    @IBOutlet weak var sortPicker: UIPickerView!
    
    var gender: String?
    var sector: String?
    var status: String?
    var region: String?
    var sortBy: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.delegate = self
        sectorPicker.delegate = self
        statusPicker.delegate = self
        regionPicker.delegate = self
        sortPicker.delegate = self
        
        //hide all criteria pickers
        genderPicker.hidden = true
        sectorPicker.hidden = true
        statusPicker.hidden = true
        regionPicker.hidden = true
        sortPicker.hidden = true
        
        self.setupDefaultCriteria()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.showAppropriatePicker()
    }
    
    func setupDefaultCriteria() {
        gender = "Both"
        sector = "Any"
        status = "Fundraising"
        region = "Any"
        sortBy = "Amount Remaining"
    }
    
    func setupPickerID(pickerID: String) {
        pickerTag = pickerID
    }
    
    func showAppropriatePicker() {
        if pickerTag == "By Gender" {
            genderPicker.hidden = false
        } else if pickerTag == "By Sector" {
            sectorPicker.hidden = false
        } else if pickerTag == "By Loan Status" {
            statusPicker.hidden = false
        } else if pickerTag == "By Geographic Region" {
            regionPicker.hidden = false
        } else if pickerTag == "Sort By" {
            sortPicker.hidden = false
        }
    }
    
    //criteriaPicker PickerView delegate method
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle the selection
        if (pickerView == self.genderPicker) {
            gender = self.pickerView(genderPicker, titleForRow: row, forComponent: 0)
            
        }else if (pickerView == self.sectorPicker){
            sector = self.pickerView(sectorPicker, titleForRow: row, forComponent: 0)
            
        }else if (pickerView == self.statusPicker){
            status = self.pickerView(statusPicker, titleForRow: row, forComponent: 0)
        
        }else if (pickerView == self.regionPicker){
            region = self.pickerView(regionPicker, titleForRow: row, forComponent: 0)
        
        }else if (pickerView == self.sortPicker){
            sortBy = self.pickerView(sortPicker, titleForRow: row, forComponent: 0)
        }

    }
    
    // tell the picker how many rows are available for a given component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 100:
            return 3
        case 101:
            return 16
        case 102:
            return 5
        case 103:
            return 8
        case 104:
            return 7;
        default:
            return 0;
        }
    }
    
    // tell the picker how many components it will have
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // tell the picker the title for a given component
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var title: String = ""
        if pickerView == self.genderPicker {
            title = self.titleForRowInGenderPicker(row)
        }
        if pickerView == self.sectorPicker {
            title = self.titleForRowInSectorPicker(row)
        }
        if pickerView == self.statusPicker {
            title = self.titleForRowInStatusPicker(row)
        }
        if pickerView == self.regionPicker {
            title = self.titleForRowInRegionPicker(row)
        }
        if pickerView == self.sortPicker {
            title = self.titleForRowInSortPicker(row)
        }
        return title
    }

    func titleForRowInGenderPicker(row: Int) -> String {
        switch row {
        case 0:
            return "Both"
        case 1:
            return "Male"
        case 2:
            return "Female"
        default:
            return "Both"
        }
    }

    func titleForRowInSectorPicker(row: Int) -> String {
        switch row {
        case 0:
            return "Any"
        case 1:
            return "Agriculture"
        case 2:
            return "Arts"
        case 3:
            return "Clothing"
        case 4:
            return "Construction"
        case 5:
            return "Education"
        case 6:
            return "Entertainment"
        case 7:
            return "Food"
        case 8:
            return "Health"
        case 9:
            return "Housing"
        case 10:
            return "Manufacturing"
        case 11:
            return "Personal Use"
        case 12:
            return "Retail"
        case 13:
            return "Services"
        case 14:
            return "Transportation"
        case 15:
            return "Wholesale"
        default:
            return "Any"
        }
    }

    func titleForRowInStatusPicker(row: Int) -> String {
        switch row {
        case 0:
            return "Fundraising"
        case 1:
            return "Funded"
        case 2:
            return "In Repayment"
        case 3:
            return "Paid"
        case 4:
            return "Defaulted"
        default:
            return "Fundraising"
        }
    }
    
    func titleForRowInRegionPicker(row: Int) -> String {
        switch row {
        case 0:
            return "Any"
        case 1:
            return "Africa"
        case 2:
            return "Asia"
        case 3:
            return "Central America"
        case 4:
            return "Europe"
        case 5:
            return "Middle East"
        case 6:
            return "North America"
        case 7:
            return "South America"
        default:
            return "Any"
        }
    }
    
    func titleForRowInSortPicker (row: Int) -> String {
        switch row {
        case 0:
            return "Amount Remaining"
        case 1:
            return "Expiration"
        case 2:
            return "Loan Amount"
        case 3:
            return "Newest"
        case 4:
            return "Oldest"
        case 5:
            return "Popularity"
        case 6:
            return "Repayment Term"
        default:
            return "Newest"
        }
    }
    
}