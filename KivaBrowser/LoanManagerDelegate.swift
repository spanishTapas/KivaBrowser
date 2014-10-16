//
//  LoanManagerDelegate.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/6/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

@objc protocol LoanManagerDelegate {
    //Loans
    //This method is called when the list of loans retrieved from Kiva is parsed
    optional func didReceiveLoans(loans: [Loan])
    //This method is called when an error occurred
    optional func fetchingLoansFailedWithError(error: NSErrorPointer)
    optional func didReceivePagingInfo(paginator: Paginator)
    
    //Detailed Loan
    //This method is called when the Detailed Loan retrieved from Kiva is parsed
    optional func didReceiveDetailedLoan(detailedLoan: DetailedLoan)
    
    //Teams
    //This method is called when the list of teams retrieved from Kiva is parsed
    optional func didReceiveTeams(teams: [Team])
    //This method is called when an error occurred
    optional func fetchingTeamsFailedWithError(error: NSErrorPointer)
    optional func didReceiveTeamPagingInfo(paginator: Paginator)
    
    //Lenders
    //This method is called when an error occurred
    optional func fetchingLendersFailedWithError(error: NSErrorPointer)
    optional func didReceiveLenders(lenders: [Lender])
    optional func didReceiveLenderPagingInfo(paginator: Paginator)
}





