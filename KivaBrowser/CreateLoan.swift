//
//  CreateLoan.swift
//  KivaBrowser
//
//  Created by wanming zhang on 7/29/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
extension Loan {
    //to convert raw JSON data into an array of Loan objects.
    class func loanArrayFromJsonData(data: NSData, error: NSErrorPointer) -> [Loan]? {
        //parse out JSON data
        //var loanArr = NSMutableArray()
        var loanArr = [Loan]()
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json data: \(reason)")
        }else if let jsonDic = parsedObj as? NSDictionary {
            println("Json comes back as a Dictionary")
            if let loans = jsonDic.valueForKey("loans") as? [NSDictionary] {
                //println("in CreateLoan, \(loans.count) loans")
                //We loop through the loans and look into each NSDictionary inside it. We then create a Loan object and fill it with the necessary information, then adding it to the mutable array.
                for loanDic in loans {
                    let loan: Loan = self.createLoanFrom(loanDic as NSDictionary)
                    //println("\(loan.country)")
                    loanArr.append(loan)
                    //println("loanArr.count: \(loanArr.count)")
                }
                return loanArr
            }
        }else if let jsonArr = parsedObj as? NSArray {
            println("Json comes back as an Array.")
        }
        return nil
    }
    
    class func createLoanFrom(loanDic: NSDictionary) -> Loan {
        let loan = Loan(loanDic: loanDic)
        return loan
    }

}