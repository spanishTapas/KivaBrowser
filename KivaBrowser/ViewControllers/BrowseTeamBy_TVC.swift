//
//  BrowseTeamBy_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/6/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class BrowseTeamBy_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCriteriaStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lending Teams"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //#pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BrowseBy"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        cell.textLabel!.text = self.titleForRow(indexPath.row)
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
    
    //#pragma mark - Navigation
    //press search button and segue to CriteriaPicker
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender is UITableViewCell {
            if segue.identifier == "BrowseTeamBy" {
                let cell: UITableViewCell = sender as! UITableViewCell
                if let browseBy = cell.textLabel!.text {
                    let destVC = segue.destinationViewController as! Teams_TVC
                    //set up destinationVC title
                    destVC.title =  "\(browseBy)"
                    self.selectedCriteriaStr = self.selectCriteria(browseBy)
                    //set browse criteria for destinationVC
                    destVC.setsortByStr(self.selectedCriteriaStr)
                    //println("BrowseTeamBy_TVC self.selectedCriteriaStr = \(self.selectedCriteriaStr)")
                }
            }
        }
    }
    
    
    func titleForRow(row: Int) -> String {
        switch row {
        case 0:
            return "By Newest"
        case 1:
            return "By Oldest"
        case 2:
            return "By Member_Count"
        case 3:
            return "By Loan_Count"
        case 4:
            return "By Loaned_Amount"
        case 5:
            return "By Query_Relevance"
        default:
            return ""
        }
    }

    func selectCriteria(criteria: String) -> String {
        //newest, oldest, member_count, loan_count, loaned_amount, query_relevance
        var criteriaStr: String = ""
        if criteria == "By Newest" {
            criteriaStr = "&sort_by=newest"
        } else if criteria == "By Oldest" {
            criteriaStr = "&sort_by=oldest"
        } else if criteria == "By Member_Count" {
            criteriaStr = "&sort_by=member_count"
        } else if criteria == "By Loan_Count" {
            criteriaStr = "&sort_by=loan_count"
        } else if criteria == "By Loaned_Amount" {
            criteriaStr = "&sort_by=loaned_amount"
        } else if criteria == "By Query_Relevance" {
            criteriaStr = "&sort_by=query_relevance"
        } else {
            criteriaStr = ""
        }
        
        return criteriaStr
    }

}