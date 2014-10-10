//
//  Team.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/3/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Team {
    
    enum KivaImageFormat: Int {
        case KivaImageFormatSquare = 1
        case KivaImageFormatSpecifyBoth = 2
        case KivaImageFormatFullSize = 64
    }
    
    var team_id: Int?
    var category: String = ""
    var description: String = ""
    var loan_because: String = ""
    var team_since: String = ""
    var website_url: String = ""
    var shortname: String = ""
    var imgDic: NSDictionary?
    //var imageID: Int?
    //var template_id: Int?
    
    var member_count: Int = 0
    var loaned_amount: Int = 0
    var membership_type: String = ""
    var whereabouts: String = ""
    var name: String = ""
    var loan_count: Int = 0
    
    init(teamDic: NSDictionary) {
        if let team_id = teamDic.valueForKey("id") as? Int {
            self.team_id = team_id
        }
        if let category = teamDic.valueForKey("category")as? String {
            self.category = category
        }
        if let description = teamDic.valueForKey("description") as? String {
            self.description = description
        }
        if let loan_because = teamDic.valueForKey("loan_because") as? String {
            self.loan_because = loan_because
        }
        
        if let jsonStr = teamDic.valueForKey("team_since") as? String {
            let date: NSDate = Team.dateWithJsonString(jsonStr)
            let dateStr = Team.stringFromDate(date)
            self.team_since = dateStr
        }
        
        if let website_url = teamDic.valueForKey("website_url") as? String {
            self.website_url = website_url
        }
        
        if let shortname = teamDic.valueForKey("shortname") as? String {
            self.shortname = shortname
        }
        
        if let imgDic = teamDic.valueForKey("image") as? NSDictionary {
            self.imgDic = imgDic
            //println("Team... imgDic = \(imgDic)")
        }
        if let member_count = teamDic.valueForKey("member_count") as? Int {
            self.member_count = member_count
        }
        if let loaned_amount = teamDic.valueForKey("loaned_amount") as? Int {
            self.loaned_amount = loaned_amount
        }
        if let membership_type = teamDic.valueForKey("membership_type") as? String {
            self.membership_type = membership_type
        }
        if let whereabouts = teamDic.valueForKey("whereabouts") as? String {
            self.whereabouts = whereabouts
        }
        if let name = teamDic.valueForKey("name") as? String {
            self.name = name
        }
        if let loan_count = teamDic.valueForKey("loan_count") as? Int {
            self.loan_count = loan_count
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

