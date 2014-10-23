//
//  LendingAction_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/17/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class LendingAction_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, LoanManagerDelegate {
    
    let loanManager: LoanManager
    
    var lendingActionArray = [LendingAction]()
    var searchResultsArray = [LendingAction]()
    
    required init(coder aDecoder: NSCoder) {
        
        self.loanManager = LoanManager()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loanManager.fetcher = JsonDataFetcher()
        loanManager.fetcher!.delegate = loanManager
        loanManager.delegate = self
        
        self.title = "Latest Lending_Action"
        //self.searchDisplayController?.searchResultsTableView.registerClass(LoanCell.self, forCellReuseIdentifier: "LoanCell")
        self.loadLendingActions()
        
        self.refreshControl!.addTarget(self, action:"refresh", forControlEvents: .ValueChanged)
    }
    
    //#pragma mark - set Model
    func loadLendingActions() {
        self.loanManager.fetchLending_Actions()
        //self.loanManager.fetchTeamsBy(self.sortByStr, pageNum: pageNum)
    }
    
    //LoanManagerDelegate
    func didReceiveLending_Actions(lending_actions: [LendingAction]) {
        self.lendingActionArray = lending_actions
        self.tableView.reloadData()
    }
    
    func fetchingLending_ActionsFailedWithError(error: NSErrorPointer){
        
    }
    
//    func reachedLastPage() -> Bool {
//        //get paging Dictionary for this search
//        return self.currPageNum >= self.paginator.pages
//    }
    
    //LoanManagerDelegate
//    func didReceiveTeamPagingInfo(paginator: Paginator) {
//        self.paginator = paginator
//        println("Teams_TVC paginator.pages: \(self.paginator.pages)")
//    }
    
    //pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1;
    }
    
    // lets the UITableView know how many rows it should display
    // in this case, just the count of dictionaries in the Model's array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController?.searchResultsTableView {
            //println("LendingAction_TVC tableView numberOfRowsInSection, searchResultsTableView...")
            let numberOfRows = searchResultsArray.count
            //println("numberOfRows = \(numberOfRows)")
            return numberOfRows
        } else {
            let numberOfRows = lendingActionArray.count
            //println("LendingAction_TVC number of rows: \(numberOfRows)")
            return numberOfRows
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LendingActionCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as LendingActionCell
        if tableView == self.searchDisplayController?.searchResultsTableView {
            let lending_action = searchResultsArray[indexPath.row] as LendingAction
            self.configureCell(cell, lending_action: lending_action)
        } else {
            let lending_action = lendingActionArray[indexPath.row] as LendingAction
            self.configureCell(cell, lending_action: lending_action)
        }
        return cell
    }
    
    func configureCell(cell: LendingActionCell, lending_action: LendingAction) {
        if lending_action.loan != nil {
            //setup image
            let imageURL = KivaImage.urlForImageFormat(lending_action.loan!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: cell.borrowerImage)
            LendingAction_TVC.squareImageOfBorrowerForImageView(lending_action, imgView: cell.borrowerImage)
            
            cell.borrowerNameLabel.text = "\(lending_action.loan!.name)"
            cell.borrowerCountryLabel.text = "\(lending_action.loan!.country)"
            cell.loanSectorLabel.text = "\(lending_action.loan!.sector)"
            cell.amountLabel.text = "$ \(lending_action.loan!.amount)"
            
            let amount = lending_action.loan!.amount
            let funded = lending_action.loan!.funded_amount
            let remaining = amount - funded
            let progress = float_t(funded)/float_t(amount)
            cell.fundedProgressView.progress = progress
            cell.fundedProgressView.progressTintColor = UIColor.greenColor()
            
            let fundedPercentage = progress * 100
            let percentageStr = "\(Int(fundedPercentage))% funded"
            let remainingStr = "$\(remaining) to go!"
            cell.remainingLabel.text = "\(percentageStr)\n\(remainingStr)"
        }
        
    }
    
    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98.0
    }
    //#pragma mark - Refreshing
    // Fires off a block on a queue to fetch data from kiva
    @IBAction func refresh() {
        self.refreshControl!.beginRefreshing()
        let fetchQ: dispatch_queue_t = dispatch_queue_create("Kiva Fetch", nil)
        dispatch_async(fetchQ, {
            self.loadLendingActions()
            dispatch_async(dispatch_get_main_queue(), {
                self.refreshControl!.endRefreshing()
            })
        })
    }
    
    class func squareImageOfBorrowerForImageView(lending_action: LendingAction, imgView: UIImageView) {
        
        let imageURL = KivaImage.urlForImageFormat(lending_action.loan!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
        
        let imageFetchQ: dispatch_queue_t = dispatch_queue_create("image fetcher", nil)
        dispatch_async(imageFetchQ, {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true//not good
            let imageData: NSData = NSData(contentsOfURL: imageURL)!//could take a while
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false//not good
            // UIImage is one of the few UIKit objects which is thread-safe, so we can do this here
            let image: UIImage = UIImage(data: imageData)!
            dispatch_async(dispatch_get_main_queue(), {
                imgView.image = image
            })
            
        })
    }
    
    class func squareImageOfLenderForImageView(lending_action: LendingAction, imgView: UIImageView) {
        
        let imageURL = KivaImage.urlForImageFormat(lending_action.lender!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
        
        let imageFetchQ: dispatch_queue_t = dispatch_queue_create("image fetcher", nil)
        dispatch_async(imageFetchQ, {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true//not good
            let imageData: NSData = NSData(contentsOfURL: imageURL)!//could take a while
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false//not good
            // UIImage is one of the few UIKit objects which is thread-safe, so we can do this here
            let image: UIImage = UIImage(data: imageData)!
            dispatch_async(dispatch_get_main_queue(), {
                imgView.image = image
            })
            
        })
    }
    
    //#pragma mark - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController]
        if sender is LendingActionCell {
            let view: UIView? = sender.superview
            var tableView = UITableView()
            if view?.superview is UITableView {
                tableView = view?.superview as UITableView
            } else if view is UITableView {
                tableView = view as UITableView
            } else {
                //NSAssert(NO, @"UITableView shall always be found.");
            }
            let indexPath: NSIndexPath = tableView.indexPathForCell(sender as UITableViewCell)!
            
            if segue.identifier == "ShowLendingActionDetail" {
                if tableView == self.searchDisplayController?.searchResultsTableView {
                    let selectedLending_Action: LendingAction = self.searchResultsArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailLendingAction_VC
                    myDestVC.setLending_Action(selectedLending_Action)
                } else {
                    let selectedLending_Action: LendingAction = self.lendingActionArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailLendingAction_VC
                    myDestVC.setLending_Action(selectedLending_Action)
                }
            }
        }
    }
}