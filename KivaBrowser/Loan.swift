//
//  Loan.swift
//  KivaBrowser
//
//  Created by wanming zhang on 7/28/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Loan {
    enum KivaImageFormat: Int {
    case KivaImageFormatSquare = 1
    case KivaImageFormatSpecifyBoth = 2
    case KivaImageFormatFullSize = 64
    }
    
    //implicitly unwrapped optionals? or optionals ?
    var loan_id: Int?
    var name: String = ""
    var amount: Int = 0
    var locationDic: NSDictionary?
    var country: String = ""
    var sector: String = ""
    var status: String = ""
    var use: String = ""
    var imgDic: NSDictionary?
    
    init(loanDic: NSDictionary) {
        self.loan_id = loanDic.valueForKey("id") as? Int
        
        if let name = loanDic.valueForKey("name") as? String {
            self.name = name
        }
        
        if let amount = loanDic.valueForKey("loan_amount") as? Int {
            self.amount = amount
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
        
        self.imgDic = loanDic.valueForKey("image") as? NSDictionary
        
        if let sector = loanDic.valueForKey("sector") as? NSString {
            self.sector = sector
        }
        
        if let status = loanDic.valueForKey("status") as? NSString {
            self.status = status
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
