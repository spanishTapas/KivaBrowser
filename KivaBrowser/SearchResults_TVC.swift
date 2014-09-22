//
//  SearchResults_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 9/5/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class SearchResults_TVC: Loans_TVC, UIScrollViewDelegate {
    var requestString: String = ""
    var scopeStr: String = ""
    //@property (weak, nonatomic) IBOutlet UISearchBar *loanFilter;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currPageNum = 1
        self.loadLoansForPage(1)
        self.loanManager.fetchPagingInfoByRequest(requestString)
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }

    func setRequestStr(requestStr: String) {
        self.requestString = requestStr
    }
    
    override func loadLoansForPage(pageNum: Int) {
        //println("SearchResults_TVC loadLoansForPage self.loanManager.fetcher = \(self.loanManager.fetcher)")
        self.loanManager.fetchSearchResultsByRequest(requestString, pageNum: pageNum)
    }

    func reachedLastPage() -> Bool {
        //get paging Dictionary for this search
        return self.currPageNum >= self.paginator.pages
    }

    //#pragma mark - LoanManagerDelegate
    override func didReceivePagingInfo(paginator: Paginator) {
        self.paginator = paginator
        //println("LatestLoans paginator.pages: \(self.paginator.pages)")
    }

    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //set up label
        let footerView: UIView = UIView(frame: CGRectMake(0, 0, 400, 28))
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, 400, 28))
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = NSTextAlignment.Center
        
        
        if let pages = self.paginator.pages {
            let text: String = "\(self.currPageNum) out of \(pages) pages"
            //println("\(self.currPageNum) out of \(self.paginator.pages) pages")
            label.text = text
        }
        //        if (tableView == self.searchDisplayController.searchResultsTableView) {
        //            println("viewForFooterInsection...\(tableView)")
        //            let count: Int? = self.searchedResultsArray?.count
        //            label.text = "\(count) loan(s)"
        //        } else {
        //            let text: String = "\(self.currPageNum) out of \(self.paginator.pages) pages"
        //            label.text = text
        //        }
        
        footerView.addSubview(label)
        self.tableView.tableFooterView = footerView
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98.0
    }
    
//    override func configureCell(cell: LoanCell, loan: Loan) {
//        
//        cell.countryLabel.text = loan.country
//        cell.amountLabel.text = "$ \(loan.amount)"
//        cell.nameLabel.text = loan.name
//        cell.descLabel.text = loan.use
//        self.squareImageOfLoanForImageView(loan, imgView: cell.loanImage)
////        if let countryLabel = cell.viewWithTag(100) as? UILabel {
////            //println("Loans_TVC countryLabel = \(countryLabel)")
////            countryLabel.text = loan.country
////        }
////        
////        if let amountLabel = cell.viewWithTag(101) as? UILabel {
////            amountLabel.text = "$ \(loan.amount)"
////        }
////        
////        if let nameLabel = cell.viewWithTag(102) as? UILabel {
////            nameLabel.text = loan.name
////        }
////        
////        if let descLabel = cell.viewWithTag(103) as? UILabel {
////            descLabel.text = loan.description
////        }
////        
////        if let loanImage = cell.viewWithTag(104) as?  UIImageView {
////            self.squareImageOfLoanForImageView(loan, imgView: loanImage)
////        }
//    }
    
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
                    //self.currPageNum++;
                }
            }
        }
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
            let indexPath: NSIndexPath = self.tableView.indexPathForCell(sender as UITableViewCell)!
            if segue.identifier == "Show Details" {
                let selectedLoan: Loan = self.loanArray[indexPath.row]
                let myDestVC = segue.destinationViewController as DetailedLoanVC
                myDestVC.setLoan_id(selectedLoan.loan_id!)
                println("LatestLoans_TVC prepareForSegue selectedLoan.loan_id = \(selectedLoan.loan_id)")
                
            }
        }

    }
}