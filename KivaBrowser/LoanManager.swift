//
//  LoanManager.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/6/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class LoanManager :JsonDataFetcherDelegate {
    var fetcher: JsonDataFetcher?
    weak var delegate: LoanManagerDelegate?
    
    func fetchLatestLoans(pageNum: Int) {
        self.fetcher?.fetchLatestLoanData(pageNum)
        //println("LoanManager self.fetcher = \(self.fetcher)")
    }
    
    func fetchPagingInfo() {
        self.fetcher?.getPagingInfo()
    }
    
    func fetchPagingInfoByRequest(requestStr: String) {
        self.fetcher?.getPagingInfoByRequest(requestStr)
    }

    func fetchDetailedLoanByID(loan_id: Int) {
        self.fetcher?.fetchDetailedLoanByID(loan_id)
    }
    
    func fetchSearchResultsByRequest(requestStr: String, pageNum: Int) {
        self.fetcher?.fetchLoansByRequest(requestStr, pageNum: pageNum)
        //println("LoanManager fetchSearchResultsByRequest requestStr = \(requestStr)")
        //println("LoanManager self.fetcher = \(self.fetcher)")
    }
    
    func fetchTeamsBy(sortByStr: String, pageNum: Int) {
        //println("LoanManager fetchTeams()......")
        self.fetcher?.fetchTeamsBy(sortByStr, pageNum: pageNum)
    }
    
    func fetchTeamPagingInfoBy(sortByStr: String) {
        println("LoanManager fetchTeamPagingInfoBy...")
        self.fetcher?.getTeamPagingInfoSortedBy(sortByStr)
    }
    
    func fetchLatestLenders(pageNum: Int) {
        self.fetcher?.fetchLatestLendersData(pageNum)
    }
    func fetchLatestLendersPagingInfo() {
        self.fetcher?.getLatestLendersPagingInfo()
    }
    func fetchLendersBy(requestStr: String, pageNum: Int) {
        //println("LoanManager fetchLenders()......")
        self.fetcher?.fetchLendersByRequest(requestStr, pageNum: pageNum)
    }
    func fetchLenderPagingInfoBy(requestStr: String) {
        self.fetchLenderPagingInfoBy(requestStr)
    }
    
    func receivedJsonData(data: NSData) {
        var error: NSError?
        if let loans: [Loan]? = Loan.loanArrayFromJsonData(data, error: &error) {
            //println("LoanManager loans.count: \(loans?.count)")
            if (error != nil) {
                self.delegate?.fetchingLoansFailedWithError!(&error)
            } else {
                self.delegate?.didReceiveLoans!(loans!)
            }
        }
    }
    
    func receivedDetailedLoanJson(jsonData: NSData) {
        var error: NSError?
        let detailedLoan: DetailedLoan? = DetailedLoan.detailedLoanFromJsonData(jsonData, error: &error)
        if (error != nil) {
            self.delegate?.fetchingLoansFailedWithError!(&error)
        } else {
            self.delegate?.didReceiveDetailedLoan!(detailedLoan!)
        }
        
    }
    
    func fetchingDataFailedWithError(error: NSErrorPointer){
        println("Error = \(error.debugDescription)")
    }
    
    func receivedPagingInfo(data: NSData) {
        //println("LoanManager paginator")
        var error: NSError?
        let paginator: Paginator? = Paginator.paginatorFromJsonData(data, error: &error)
        
        if (error != nil) {
            self.delegate?.fetchingLoansFailedWithError!(&error)
        } else {
            self.delegate?.didReceivePagingInfo!(paginator!)
        }
    }

    func receivedTeamJsonData(data: NSData) {
        var error: NSError?
        if let teams: [Team]? = Team.TeamArrayFromJsonData(data, error: &error) {
            println("LoanManager teams.count: \(teams?.count)")
            if (error != nil) {
                self.delegate?.fetchingTeamsFailedWithError!(&error)
            } else {
                self.delegate?.didReceiveTeams!(teams!)
            }
        }
    }

    func receivedTeamPagingInfo(data: NSData) {
        //println("LoanManager teamPaginator")
        var error: NSError?
        let paginator: Paginator? = Paginator.paginatorFromJsonData(data, error: &error)
        
        if (error != nil) {
            self.delegate?.fetchingTeamsFailedWithError!(&error)
        } else {
            self.delegate?.didReceiveTeamPagingInfo!(paginator!)
            
        }
    }
    
    func receivedLenderJsonData(data: NSData) {
        var error: NSError?
        if let lenders: [Lender]? = Lender.LenderArrayFromJsonData(data, error: &error) {
            println("LoanManager lenders.count: \(lenders?.count)")
            if (error != nil) {
                self.delegate?.fetchingLendersFailedWithError!(&error)
            } else {
                self.delegate?.didReceiveLenders!(lenders!)
            }
        }
    }
    
    func receivedLenderPagingInfo(data: NSData) {
        //println("LoanManager lenderPaginator")
        var error: NSError?
        let paginator: Paginator? = Paginator.paginatorFromJsonData(data, error: &error)
        
        if (error != nil) {
            
            self.delegate?.fetchingLendersFailedWithError!(&error)
        } else {
            self.delegate?.didReceiveLenderPagingInfo!(paginator!)
            
        }
    }
    
    init() {
        println("LoanManager: \(self)")
        println("LoanManager self.fetcher: \(self.fetcher)")
        println("LoanManager self.delegate: \(self.delegate)")
    }
}