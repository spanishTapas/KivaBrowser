//
//  CreateLender.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/13/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension Lender {
    //to convert raw JSON data into an array of Lender objects.
    class func LenderArrayFromJsonData(data: NSData, error: NSErrorPointer) -> [Lender]? {
        //parse out JSON data
        var lenderArr = [Lender]()
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json data: \(reason)")
        }else if let jsonDic = parsedObj as? NSDictionary {
            println("Json comes back as a Dictionary")
            if let lenders = jsonDic.valueForKey("lenders") as? [NSDictionary] {
                //println("in CreateLender, \(lenders.count) lenders")
                //We loop through the lenders and look into each NSDictionary inside it. We then create a Lender object and fill it with the necessary information, then adding it to the mutable array.
                for lenderDic in lenders {
                    let lender: Lender = self.createLenderFrom(lenderDic)
                    
                    lenderArr.append(lender)
                    
                }
                return lenderArr
            }
        }else if let teamArr = parsedObj as? NSArray {
            println("Lender...Json comes back as an Array.")
        }
        return nil
    }
    
    class func createLenderFrom(lenderDic: NSDictionary) ->  Lender {
        let lender = Lender(lenderDic: lenderDic)
        return lender
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