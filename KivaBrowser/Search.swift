//
//  Search.swift
//  KivaBrowser
//
//  Created by wanming zhang on 9/5/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Search: NSObject {
    
    class func genderStr(gender: String) -> String {
        var genderStr: String
        if gender == "Male" {
            genderStr = "&gender=male"
        } else if gender == "Female" {
            genderStr = "&gender=female"
        } else {
            genderStr = ""
        }
        return genderStr
    }

    class func sectorStr(sector: String) -> String {
        var sectorStr: String
        
        if sector == "Any" {
            sectorStr = ""
        } else {
            sectorStr = "&sector=\(sector)"
        }
        return sectorStr
    }
    
    class func statusStr(status: String) -> String {
        var statusStr: String
        if status == "Fundraising" {
            statusStr = "&status=fundraising"
        } else if status == "Funded" {
            statusStr = "&status=funded"
        } else if status == "In Repayment" {
            statusStr = "&status=in_repayment"
        } else if status == "Paid" {
            statusStr = "&status=paid"
        } else if status == "Defaulted" {
            statusStr = "&status=ended_with_loss"
        } else {
            return ""
        }
        return statusStr
    }
    
    class func regionStr(region: String) -> String {
        var regionStr: String
        
        if region == "Any" {
            regionStr = ""
        } else if region == "Africa" {
            regionStr = "&region=af"
        } else if region == "Asia" {
            regionStr = "&region=as"
        } else if region == "Central America" {
            regionStr = "&region=ca"
        } else if region == "Europe" {
            regionStr = "&region=ee,we"
        } else if region == "Middle East" {
            regionStr = "&region=me"
        } else if region == "North America" {
            regionStr = "&region=na"
        } else if region == "Sorth America" {
            regionStr = "&region=sa"
        } else {
            regionStr = ""
        }
        return regionStr
    }
    
    class func sortByStr(sortBy: String) -> String {
        var sortByStr: String
        
        if sortBy == "Amount Remaining" {
            sortByStr = "&sort_by=amount_remaining"
        } else if sortBy == "Expiration" {
            sortByStr = "&sort_by=expiration"
        } else if sortBy == "Loan Amount" {
            sortByStr = "&sort_by=loan_amount"
        } else if sortBy == "Newest" {
            sortByStr = "&sort_by=newest"
        } else if sortBy == "Oldest" {
            sortByStr = "&sort_by=oldest"
        } else if sortBy == "Popularity" {
            sortByStr = "&sort_by=popularity"
        } else if sortBy == "Repayment Term" {
            sortByStr = "&sort_by=repayment_term"
        } else {
            sortByStr = "&sort_by=random"
        }
        return sortByStr
    }

}