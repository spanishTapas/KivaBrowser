//
//  Lenders_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/13/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class Lenders_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, LoanManagerDelegate{
    let loanManager: LoanManager
    
    var lenderArray = [Lender]()
    var searchResultsArray = [Lender]()
    
    var requestStr: String = ""
    var isLoading: Bool
    var currPageNum: Int
    var paginator: Paginator
    
    required init(coder aDecoder: NSCoder) {
        
        self.loanManager = LoanManager()
        self.paginator = Paginator()
        self.currPageNum = 1
        self.isLoading = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loanManager.fetcher = JsonDataFetcher()
        loanManager.fetcher!.delegate = loanManager
        loanManager.delegate = self
        
        self.loadLendersForPage(1)
        self.loanManager.fetchLatestLendersPagingInfo()
        
        self.refreshControl!.addTarget(self, action:"refresh", forControlEvents: .ValueChanged)
        
        self.title = "Lenders"
    }
    
//    func setsortByStr(sortByStr: String) {
//        self.sortByStr = sortByStr
//    }
   // #pragma mark - set Model
    func loadLendersForPage(pageNum: Int) {
        self.loanManager.fetchLatestLenders(pageNum)
    }
    
    //LoanManagerDelegate
    func didReceiveLenders(lenders: [Lender]) {
        if currPageNum == 1 {
            lenderArray = lenders as [Lender]
        } else {
            self.lenderArray += lenders
        }
        self.isLoading = false
        self.tableView.reloadData()
    }
    
    func fetchingLendersFailedWithError(error: NSErrorPointer) {
        
    }
    
    func reachedLastPage() -> Bool {
        //get paging Dictionary for this search
        return self.currPageNum >= self.paginator.pages
    }
    
    //LoanManagerDelegate
    func didReceiveLenderPagingInfo(paginator: Paginator) {
        self.paginator = paginator
        //println("Lenders_TVC paginator.pages: \(self.paginator.pages)")
    }
    
    //pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1;
    }
    
    // lets the UITableView know how many rows it should display
    // in this case, just the count of dictionaries in the Model's array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController?.searchResultsTableView {
            //println("Loans_TVC tableView numberOfRowsInSection, searchResultsTableView...")
            let numberOfRows = searchResultsArray.count
            //println("numberOfRows = \(numberOfRows)")
            return numberOfRows
        } else {
            let numberOfRows = lenderArray.count
            //println("Lenders_TVC number of rows: \(numberOfRows)")
            return numberOfRows
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LenderCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as LenderCell
        if tableView == self.searchDisplayController?.searchResultsTableView {
            let lender = searchResultsArray[indexPath.row] as Lender
            self.configureCell(cell, lender: lender)
        } else {
            let lender = lenderArray[indexPath.row] as Lender
            self.configureCell(cell, lender: lender)
        }
        return cell
    }
    
    func configureCell(cell: LenderCell, lender: Lender) {

        if lender.imgDic != nil {
            let imageURL = KivaImage.urlForImageFormat(lender.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: cell.imageView)
        }
        
        cell.textLabel.text = lender.name
        
        if lender.whereabouts != "" {
            cell.detailTextLabel?.text = "\(lender.whereabouts) \(lender.country_code)"
        } else if lender.country_code != "" {
            cell.detailTextLabel?.text = "\(lender.country_code)"
        } else {
            cell.detailTextLabel?.text = "Location Unknown"
        }
        
    }
    
    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 28.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //set up label
        let footerView: UIView = UIView(frame: CGRectMake(0, 0, 320, 44))
        
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, 320, 28))
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        
        if let pages = self.paginator.pages {
            let text: String = "\(self.currPageNum) out of \(pages) pages"
            //println("LatestLenders_TVC...\(text)")
            label.text = text
            //println("\(label.text)")
        }
        if tableView != self.searchDisplayController?.searchResultsTableView {
            footerView.addSubview(label)
            tableView.tableFooterView = footerView
        }
        
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    //#pragma mark - Refreshing
    // Fires off a block on a queue to fetch data from kiva
    @IBAction func refresh() {
        self.refreshControl!.beginRefreshing()
        let fetchQ: dispatch_queue_t = dispatch_queue_create("Kiva Fetch", nil)
        dispatch_async(fetchQ, {
            //self.loadTeamsForPage(self.currPageNum)
            dispatch_async(dispatch_get_main_queue(), {
                self.refreshControl!.endRefreshing()
            })
        })
    }
    //#pragma mark - UIScrollViewDelegate Methods
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // when reaching bottom, load a new page
        let scrollViewHeight = scrollView.bounds.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if (scrollOffset + scrollViewHeight >= scrollContentSizeHeight) {
            if self.isLoading == false {
                self.isLoading = true
                if (!self.reachedLastPage()) {
                    self.loadLendersForPage(++self.currPageNum)
                }
            }
        }
    }
    
    //#pragma mark Search Bar and Search Display Controller
    
    //#pragma mark Content Filtering

    func filterContentForSearchText(searchText: String, scope: String) {
        
        if !searchText.isEmpty {
            if scope == "Name" {
                self.searchResultsArray = self.lenderArray.filter({ (lender: Lender) -> Bool in
                    var stringMatch = lender.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return stringMatch != nil
                })
            }
            
            if scope == "Location" {
                self.searchResultsArray = self.lenderArray.filter({ (lender: Lender) -> Bool in
                    var locationMatch = lender.whereabouts.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    var countryMatch = lender.country_code.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return (locationMatch != nil) || (countryMatch != nil)
                })
            }
            
            if scope == "Occupation" {
                self.searchResultsArray = self.lenderArray.filter({ (lender: Lender) -> Bool in
                    var stringMatch = lender.occupation.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return stringMatch != nil
                })
            }
        }
    }
    
    //#pragma mark - UISearchDisplayController Delegate Methods
    func searchDisplayController(controller: UISearchDisplayController, willUnloadSearchResultsTableView tableView: UITableView) {
        // search is done so get rid of the search FRC and reclaim memory
    }
    
    //  The method runs the text filtering function whenever the user changes the search string in the search bar.
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        // Tells the table data source to reload when text changes
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        // Tells the table data source to reload when scope bar selection changes
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
        
        // Return true to cause the search result table view to be reloaded.
        return true
    }
    
    //#pragma mark - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController]
        if sender is LenderCell {
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
            if segue.identifier == "ShowLender" {
                if tableView == self.searchDisplayController?.searchResultsTableView {
                    let selectedLender: Lender = self.searchResultsArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailedLender_VC
                    myDestVC.setLender(selectedLender)
                } else {
                    let selectedLender: Lender = self.lenderArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailedLender_VC
                    myDestVC.setLender(selectedLender)

                }
            }
        }
    }
}