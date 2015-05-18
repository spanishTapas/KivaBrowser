//
//  Loans_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 7/27/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

// the Model for this TableViewController
// an array of dictionaries of Kiva Loan information
// obtained using Kiva API
class Loans_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource, LoanManagerDelegate, UISearchBarDelegate,UISearchDisplayDelegate{
    
    let loanManager: LoanManager
    
    var loanArray = [Loan]()
    var searchResultsArray = [Loan]()
    
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
        
        self.searchDisplayController?.searchResultsTableView.registerClass(LoanCell.self, forCellReuseIdentifier: "LoanCell")
    }
    
    //#pragma mark - set Model
    func loadLoansForPage(pageNum: Int) {
        //will be implemented in subclasses
    }
    
    //LoanManagerDelegate
    func didReceiveLoans(loans: [Loan]) {
        if (currPageNum == 1) {
            loanArray = loans as [Loan]
            println("Loans_TVC loanArray = \(loanArray.count)")
        }else{
            //self.loanArray.addObjectsFromArray(loans)
            self.loanArray += loans
        }
        self.isLoading = false
        self.tableView.reloadData()
    }
    
    func fetchingLoansFailedWithError(error: NSErrorPointer) {
        
    }
    
    func didReceivePagingInfo(paginator: Paginator){
        //will implement in subclass
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
            let numberOfRows = loanArray.count
            //println("Loans_TVC number of rows: \(numberOfRows)")
            return numberOfRows
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LoanCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! LoanCell
        if tableView == self.searchDisplayController?.searchResultsTableView {
            let loan = searchResultsArray[indexPath.row] as Loan
            self.configureCell(cell, loan: loan)
        } else {
            let loan = loanArray[indexPath.row] as Loan
            self.configureCell(cell, loan: loan)
        }
        return cell
    }
    
    func configureCell(cell: LoanCell, loan: Loan) {
        
        cell.countryLabel.text = loan.country

        let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(17), NSForegroundColorAttributeName: UIColor.orangeColor()]
        
        let amountStr = "$ \(loan.amount)"
        var attrAmountStr = NSMutableAttributedString(string: amountStr, attributes:attributes)
        cell.amountLabel.attributedText = attrAmountStr
        
        cell.nameLabel.text = loan.name
        cell.descLabel.text = loan.use
        
        if loan.imgDic != nil {
            let imageURL = KivaImage.urlForImageFormat(loan.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: cell.loanImage)
        }
    }
    
}








