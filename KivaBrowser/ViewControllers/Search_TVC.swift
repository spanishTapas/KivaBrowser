//
//  Search_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 9/3/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class Search_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var searchButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    let button_height: CGFloat = 44
    
    var selectedCriteriaStr: String = ""
    
    var criteria: Dictionary<String, String>?
    var allCriteria: Dictionary<String, String>?
    var gender: String?
    var sector: String?
    var status: String?
    var region: String?
    var sortBy: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        //self.tableView.setContentOffset(CGPointMake(0, self.tableView.frame.size.height - self.tableView.contentSize.height), animated: true)
    }

    override func viewWillLayoutSubviews() {
        self.setupSearchButton()
        self.tableView.addSubview(self.searchButton)
        //println("bounds = \(self.tableView.bounds.size.height), contentSize = \(self.tableView.contentSize.height)")
    }
    
    override func viewDidLayoutSubviews() {
        if self.tableView.bounds.size.height < self.tableView.contentSize.height + (button_height * 2) {
            
            self.tableView.setContentOffset(CGPointMake(0, button_height * 3), animated: true)
        }
    }
    
    func setupSearchButton() {
        let orientation: UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        let portrait_width: CGFloat = 200
        let landscape_width: CGFloat = 260
        //let button_height: CGFloat = 44
        
        if (orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown) {
            let portrait_x = (self.tableView.contentSize.width - portrait_width)/2
            let portrait_y = self.tableView.contentSize.height + button_height
            self.searchButton.frame = CGRectMake(portrait_x, portrait_y, portrait_width, button_height)
            //println("portrait_searchButton_frame = \(self.searchButton.frame)")
        } else if (orientation == UIInterfaceOrientation.LandscapeLeft ||
            orientation == UIInterfaceOrientation.LandscapeRight) {
            let landscape_x = (self.tableView.contentSize.width - landscape_width)/2
            let landscape_y = self.tableView.contentSize.height + button_height
            self.searchButton.frame = CGRectMake(landscape_x, landscape_y, landscape_width, button_height)
            
            //println("landscape_searchButton_frame = \(self.searchButton.frame)")
        }
        
        self.searchButton.setTitle("Search", forState: UIControlState.Normal)
        self.searchButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.searchButton.backgroundColor = UIColor.whiteColor()
        self.searchButton.layer.borderColor = UIColor.grayColor().CGColor
        self.searchButton.layer.borderWidth = 2.0
        self.searchButton.layer.cornerRadius = 15.0
        self.searchButton.userInteractionEnabled = true
        //resize label when orientation changes
        //self.searchButton.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin

        self.searchButton.addTarget(self, action: "searchButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.tableView.addSubview(self.searchButton)
    }
    
    //#pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchCriteria"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        cell.textLabel!.text = self.titleForRow(indexPath.row)
        cell.detailTextLabel?.text = self.subtitleForRow(indexPath.row)
        return cell
    }

    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //setup label
        let footerView: UIView = UIView(frame: CGRectMake(0, 0, 400
            , 28))
        footerView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = footerView
        return footerView
    }

    @IBAction func searchButtonClicked(sender: UIButton) {
        self.performSegueWithIdentifier("Search", sender: sender)
    }
    
    //#pragma mark - Navigation
    //press search button and segue to CriteriaPicker
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender is UITableViewCell {
            if segue.identifier == "PickCriteria" {
                let cell: UITableViewCell = sender as! UITableViewCell
                if let pickerID = cell.textLabel!.text {
                    let destVC = segue.destinationViewController as! CriteriaPicker
                    destVC.setupPickerID(pickerID)
                }
            }
        }
        
        if sender is UIButton {
            if segue.identifier == "Search" {
                self.selectedCriteriaStr = self.criteriaString()
                //println("Search_TVC prepareForSegue self.selectedCriteriaStr = \(self.selectedCriteriaStr)")
               let destTVC = segue.destinationViewController as! SearchResults_TVC
                destTVC.title = "Search Results"
                destTVC.setRequestStr(self.selectedCriteriaStr)
            }
        }
    }
    
    
    func titleForRow(row: Int) -> String {
        switch row {
        case 0:
            return "By Gender"
        case 1:
            return "By Sector"
        case 2:
            return "By Loan Status"
        case 3:
            return "By Geographic Region";
        case 4:
            return "Sort By"
        default:
            return " "
        }
    }

    // a helper method that looks in the Model for the search dictionary at the given 
    //row and gets the sub-criteria out of it
    
    func subtitleForRow(row: Int) -> String {
        switch row {
        case 0:
        if let g = gender {
            return g
        } else {
            return "Both"
        }
        case 1:
        if let s = sector {
            return s
        } else {
            return "Any"
        }
        case 2:
        if let s = status {
            return s
        } else {
            return "Fundraising"
        }
        case 3:
        if let r = region {
            return r
        } else {
            return "Any"
        }
        case 4:
        if let s = sortBy {
            return s
        } else {
            return "Amount Remaining"
        }
        default:
            return ""
        }
    }

    //#pragma mark - Modal View Controller
    // This unwinding method is wired up in the CriteriaPicker scene
    //   to the Cancel button.
    @IBAction func cancelSelecting(segue: UIStoryboardSegue) {
        println("cancelSelecting in Search_TVC")
    }
    
    // This unwinding method is wired up in the CriteriaPicker scene
    //   to the Done button.
    @IBAction func doneSelecting(segue: UIStoryboardSegue) {
        println("doneSelecting in Search_TVC")
        let picker: CriteriaPicker = segue.sourceViewController as! CriteriaPicker
        if picker.pickerTag == "By Gender" {
            gender = picker.gender
        } else if picker.pickerTag == "By Sector" {
            sector = picker.sector
        } else if picker.pickerTag == "By Loan Status" {
            status = picker.status
        } else if picker.pickerTag == "By Geographic Region" {
            region = picker.region
        } else if picker.pickerTag == "Sort By" {
            sortBy = picker.sortBy
        }
        //criteria = [Search criteriaForGender:gender Sector:sector LoanStatus:status GeoRegion:region SortBy:sortBy];
    }
    
    func criteriaString() -> String {
        var genderStr = "", sectorStr = "", statusStr = "", regionStr = "",
        sortByStr = "", criteriaStr = ""
        
        if let g = gender {
            genderStr = Search.genderStr(g)
        }
        if let s = sector {
            sectorStr = Search.sectorStr(s)
        }
        if let s = status {
            statusStr = Search.statusStr(s)
        }
        if let r = region {
            regionStr = Search.regionStr(r)
        }
        if let s = sortBy {
            sortByStr = Search.sortByStr(s)
        }
        criteriaStr = genderStr
        criteriaStr += sectorStr
        criteriaStr += statusStr
        criteriaStr += regionStr
        criteriaStr += sortByStr
        
        return criteriaStr
    }
    
}







