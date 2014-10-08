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
        self.team_id = teamDic.valueForKey("id") as? Int
        self.category = teamDic.valueForKey("category") as String
        self.description = teamDic.valueForKey("description") as String
        self.loan_because = teamDic.valueForKey("loan_because") as String
        self.team_since = teamDic.valueForKey("team_since") as String
        self.website_url = teamDic.valueForKey("website_url") as String
        self.shortname = teamDic.valueForKey("shortname") as String
        
        if let imgDic = teamDic.valueForKey("image") as? NSDictionary {
            self.imgDic = imgDic
            //println("Team... imgDic = \(imgDic)")
        }
        
        self.member_count = teamDic.valueForKey("member_count") as Int
        self.loaned_amount = teamDic.valueForKey("loaned_amount") as Int
        self.membership_type = teamDic.valueForKey("membership_type") as String
        self.whereabouts = teamDic.valueForKey("whereabouts") as String
        self.name = teamDic.valueForKey("name") as String
        self.loan_count = teamDic.valueForKey("loan_count") as Int        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

