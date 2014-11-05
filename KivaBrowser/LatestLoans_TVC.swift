//
//  LatestLoans_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/7/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class LatestLoans_TVC: Loans_TVC, UIScrollViewDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLoansForPage(1)
        self.loanManager.fetchPagingInfo()
        //println("LatestLoans_TVC viewDidLoad self.loanManager = \(self.loanManager)")
        self.title = "Loans"
        self.refreshControl!.addTarget(self, action:"refresh", forControlEvents: .ValueChanged)
    }
    
    override func loadLoansForPage(pageNum: Int) {
        self.loanManager.fetchLatestLoans(pageNum)
        //println("LatestLoans = \(self.loanArray?.count) loans")
    }
    
    func reachedLastPage() -> Bool {
        //get paging Dictionary for this search
        return self.currPageNum >= self.paginator.pages
    }
    
    //LoanManagerDelegate
    override func didReceivePagingInfo(paginator: Paginator) {
        self.paginator = paginator
        //println("LatestLoans paginator.pages: \(self.paginator.pages)")
    }
    
    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 28.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //set up label
        let footerView: UIView = UIView(frame: CGRectMake(0, 0, 320, 98))
        
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, 320, 28))
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        //resize label when orientation changes
        label.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
                if let pages = self.paginator.pages {
            let text: String = "\(self.currPageNum) out of \(pages) pages"
            //println("LatestLoans_TVC...\(text)")
            label.text = text
            //println("\(label.text)")
        }
        if tableView != self.searchDisplayController?.searchResultsTableView {
            footerView.addSubview(label)
        }
        
        //tableView.tableFooterView = footerView
        
        return footerView
    }
    //#pragma mark - Refreshing
    // Fires off a block on a queue to fetch data from kiva
    @IBAction func refresh() {
        self.refreshControl!.beginRefreshing()
        let fetchQ: dispatch_queue_t = dispatch_queue_create("Kiva Fetch", nil)
        dispatch_async(fetchQ, {
            self.loadLoansForPage(self.currPageNum)
            
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
                    self.loadLoansForPage(++self.currPageNum)
                }
            }
        }
    }
    //#pragma mark Search Bar and Search Display Controller
    
    //#pragma mark Content Filtering
    func filterContentForSearchText(searchText: String, scope: String) {
        
        if !searchText.isEmpty {
            if scope == "Sector" {
                self.searchResultsArray = self.loanArray.filter({ (loan: Loan) -> Bool in
                    var stringMatch = loan.sector.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return stringMatch != nil
                })
            }
            
            if scope == "Status" {
                self.searchResultsArray = self.loanArray.filter({ (loan: Loan) -> Bool in
                    var stringMatch = loan.status.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return stringMatch != nil
                })
            }
            
            if scope == "Country" {
                self.searchResultsArray = self.loanArray.filter({ (loan: Loan) -> Bool in
                    var stringMatch = loan.country.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
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
        if sender is LoanCell {
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
            if segue.identifier == "Show Details" {
                if tableView == self.searchDisplayController?.searchResultsTableView {
                    let selectedLoan: Loan = self.searchResultsArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailedLoanVC
                    myDestVC.setLoan_id(selectedLoan.loan_id!)
                } else {
                    let selectedLoan: Loan = self.loanArray[indexPath.row]
                    let myDestVC = segue.destinationViewController as DetailedLoanVC
                    myDestVC.setLoan_id(selectedLoan.loan_id!)
                    //println("LatestLoans_TVC prepareForSegue selectedLoan.loan_id = \(selectedLoan.loan_id)"
                }
            }
        }
    }
    
}



