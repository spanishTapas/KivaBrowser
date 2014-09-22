//
//  CreateDetailedLoan.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/23/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension DetailedLoan {
    
    class func detailedLoanFromJsonData(data: NSData, error: NSErrorPointer) -> DetailedLoan? {
        //parse out JSON data
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json data: \(reason)")
        } else if let jsonDic = parsedObj as? NSDictionary{
            println("CreateDetailedLoan: Json comes back as a Dictionary")
            
            if let loanArr = jsonDic.objectForKey("loans") as? NSArray {
                if let loanDic = loanArr.objectAtIndex(0) as? NSDictionary {
                    let detailedLoan = self.createDetailedLoanFrom(loanDic)
                    return detailedLoan
                }
            }
        } else if let jsonArr = parsedObj as? NSArray {
            println("CreateDetailedLoan: Json comes back as an Array.")
            if let detailedDic = jsonArr.objectAtIndex(0) as? NSDictionary {
                let detailedLoan = self.createDetailedLoanFrom(detailedDic)
                return detailedLoan
            }
        }
        return nil
    }
    
    class func createDetailedLoanFrom(detailedLoanDic: NSDictionary) -> DetailedLoan
    {
        
        let detailedLoan = DetailedLoan(detailedLoanDic: detailedLoanDic)
        return detailedLoan
    }
    
    class func dateWithJsonString(dateStr: String) -> NSDate {
        NSDateFormatter.setDefaultFormatterBehavior(NSDateFormatterBehavior.Behavior10_4)
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        
        var date: NSDate = NSDate()
        date = dateFormatter.dateFromString(dateStr)!
        
        return date
    }
    
    class func stringFromDate(date: NSDate) -> String {
        var dateStr: String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateStr = dateFormatter.stringFromDate(date)
        
        return dateStr
    }

}