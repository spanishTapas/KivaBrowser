//
//  LendingAction.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/17/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class LendingAction {
    var loan: Loan?
    var lender: Lender?
    
    init(lendingActionDic: NSDictionary) {
        if let loanDic = lendingActionDic.valueForKey("loan") as? NSDictionary {
            let loan = Loan(loanDic: loanDic)
            self.loan = loan
        }
        
        if let lenderDic = lendingActionDic.valueForKey("lender") as? NSDictionary {
            let lender = Lender(lenderDic: lenderDic)
            self.lender = lender
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}