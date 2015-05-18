//
//  DetailedLoan.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/23/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class DetailedLoan: NSObject {
    
    var name: String = ""
    var use: String = ""
    var loan_amount: Int = 0
    var funded_amount: Int = 0
    
    var disbursal_date: String = ""
    var due_date: String = ""
    var repay_term: String = ""
    var currency_loss: String = ""
    var protection: String = ""
    
    var locaDic: NSDictionary?
    var country: String = ""
    var town: String = ""
    var country_code: String?
    var geoDic: NSDictionary?
    
    var partner_id: Int = 0
    
    var sector: String = ""
    var status: String = ""
    
    //var imgDic: NSDictionary?
    var img_id: Int?
    //var borrowers: NSArray?
    var gender: String = ""

    var descDic: NSDictionary?
    var descText: String = ""
    
    init(detailedLoanDic: NSDictionary) {
        
        if let name = detailedLoanDic.valueForKey("name") as? String {
            self.name = name
        }
        
        if let use = detailedLoanDic.valueForKey("use") as? String {
            self.use = use
        }

        if let loan_amount = detailedLoanDic.valueForKey("loan_amount") as? Int {
            self.loan_amount = loan_amount
        }
        
        if let funded_amount = detailedLoanDic.valueForKey("funded_amount") as? Int {
            self.funded_amount = funded_amount
        }
        
        if let terms = detailedLoanDic.valueForKey("terms") as? NSDictionary {
            
            if let interval = terms.valueForKey("repayment_interval") as? String{
                if let term = terms.valueForKey("repayment_term") as? Int {
                    if interval == "Monthly" {
                        self.repay_term = "\(term) months"
                    } else {
                        self.repay_term = "\(term)"
                    }
                }
            }
            
            if let jsonStr = terms.valueForKey("disbursal_date") as? String {
                let disbursalDate: NSDate = DetailedLoan.dateWithJsonString(jsonStr)
                let disbursalDateStr = DetailedLoan.stringFromDate(disbursalDate)
                self.disbursal_date = disbursalDateStr
            }
            
            if let paymentsArr = terms.valueForKey("scheduled_payments") as? NSArray
            {
                if let payments = paymentsArr.objectAtIndex(0) as? NSDictionary{
                    let dueStr = payments.valueForKey("due_date") as! String
                    let dueDate = DetailedLoan.dateWithJsonString(dueStr)
                    let dueDateStr = DetailedLoan.stringFromDate(dueDate)
                    self.due_date = dueDateStr
                }
                
            }
            
            if let lossDic = terms.valueForKey("loss_liability") as? NSDictionary
            {
                if let currencyLoss = lossDic.valueForKey("currency_exchange") as? String{
                    if currencyLoss == "shared" {
                    self.currency_loss = "Possible"
                    } else {
                    self.currency_loss = "N/A"
                    }
                }
                
                if let nonpayment = lossDic.valueForKey("nonpayment") as? String {
                    if nonpayment == "lender" {
                        self.protection = "Not Covered"
                    } else {
                        self.protection = "N/A"
                    }
                }
            }
            
            if let locaDic = detailedLoanDic.valueForKey("location") as? NSDictionary {
                self.locaDic = locaDic
                if let country = self.locaDic!.valueForKey("country") as? String {
                    self.country = country
                } else {
                    self.country = ""
                }
                self.country_code = self.locaDic!.valueForKey("country_code") as? String
                
                if let town = self.locaDic!.valueForKey("town") as? String {
                    self.town = town
                } else {
                    self.town = ""
                }
                
                if let geoDic = detailedLoanDic.valueForKey("geo") as? NSDictionary {
                self.geoDic = geoDic
                }
            }
    
            if let imgDic = detailedLoanDic.valueForKey("image") as? NSDictionary {
                self.img_id = imgDic.valueForKey("id") as? Int
            }
            
            if let sector = detailedLoanDic.valueForKey("sector") as? String {
                self.sector = sector
            } else {
                self.sector = ""
            }
            
            if let status = detailedLoanDic.valueForKey("status") as? String {
                self.status = status
            } else {
                self.status = ""
            }
        }

        if let borrowersArr = detailedLoanDic.valueForKey("borrowers") as? NSArray {
            if let borrowersDic = borrowersArr.objectAtIndex(0) as? NSDictionary {
                if let genderStr = borrowersDic.valueForKey("gender") as? String {
                    if genderStr == "F" {
                        self.gender = "female"
                    } else if genderStr == "M" {
                        self.gender = "male"
                    }
                }
                
            }
        }
        
        if let descDic = detailedLoanDic.valueForKey("description") as? NSDictionary
        {
            if let textDic = descDic.valueForKey("texts") as? NSDictionary {
                if let description = textDic.valueForKey("en") as? String {
                    self.descText = description
                }
            }
        }

    }
    
}


