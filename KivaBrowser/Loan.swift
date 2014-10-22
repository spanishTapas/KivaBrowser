//
//  Loan.swift
//  KivaBrowser
//
//  Created by wanming zhang on 7/28/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Loan {
    
    //implicitly unwrapped optionals? or optionals ?
    var loan_id: Int?
    var name: String = ""
    var amount: Int = 0
    var funded_amount: Int = 0
    var locationDic: NSDictionary?
    var country: String = ""
    var sector: String = ""
    var activity: String = ""
    var status: String = ""
    var use: String = ""
    var imgDic: NSDictionary?
    var lender_count: Int = 0
    
    init(loanDic: NSDictionary) {
        self.loan_id = loanDic.valueForKey("id") as? Int
        
        if let name = loanDic.valueForKey("name") as? String {
            self.name = name
        }
        
        if let amount = loanDic.valueForKey("loan_amount") as? Int {
            self.amount = amount
        }
        if let funded_amount = loanDic.valueForKey("funded_amount") as? Int {
            self.funded_amount = funded_amount
        }
        self.locationDic = loanDic.valueForKey("location") as? NSDictionary
        if (locationDic != nil){
            if let country = locationDic!.valueForKey("country") as? String {
                self.country = country
            }
        }
    
        if let description = loanDic.valueForKey("use") as? String {
            self.use = description
        }
        
        if let imgDic = loanDic.valueForKey("image") as? NSDictionary {
            self.imgDic = imgDic
        } 
        
        if let sector = loanDic.valueForKey("sector") as? String {
            self.sector = sector
        }
        if let activity = loanDic.valueForKey("activity") as? String {
            self.activity = activity
        }
        if let status = loanDic.valueForKey("status") as? NSString {
            self.status = status
        }
        
        if let lender_count = loanDic.valueForKey("lender_count") as? Int {
            self.lender_count = lender_count
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
