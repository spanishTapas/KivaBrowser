//
//  Lender.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/12/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Lender {
    
    var name: String = ""
    var whereabouts: String = ""
    var uid: String = ""
    var occupation: String = ""
    var loan_because: String = ""
    var occupational_info: String = ""
    var member_since: String = ""
    var invitee_count: Int?
    var lender_id: String = ""
    var imgDic: NSDictionary?
    //var imageID: Int?
    //var template_id: Int?
    var personal_url: String = ""
    var country_code: String = ""
    var loan_count: Int?

    init(lenderDic: NSDictionary) {
        
        if let lender_id = lenderDic.valueForKey("lender_id") as? String {
            self.lender_id = lender_id
        }
        
        if let name = lenderDic.valueForKey("name") as? String {
            self.name = name
        }
        
        if let whereabouts = lenderDic.valueForKey("whereabouts") as? String {
            self.whereabouts = whereabouts
        }
        
        if let uid = lenderDic.valueForKey("uid") as? String {
            self.uid = uid
        }
        
        if let occupation = lenderDic.valueForKey("occupation") as? String {
            self.occupation = occupation
        }
        
        if let loan_because = lenderDic.valueForKey("loan_because") as? String {
            self.loan_because = loan_because
        }
        if let occupational_info = lenderDic.valueForKey("occupational_info") as? String {
            self.occupational_info = occupational_info
        }
        
        if let jsonStr = lenderDic.valueForKey("member_since") as? String {
            let date: NSDate = Lender.dateWithJsonString(jsonStr)
            let dateStr = Lender.stringFromDate(date)
            self.member_since = dateStr
        }
        
        if let invitee_count = lenderDic.valueForKey("invitee_count") as? Int {
            self.invitee_count = invitee_count
        }
        
        if let imgDic = lenderDic.valueForKey("image") as? NSDictionary {
            self.imgDic = imgDic
        }
        
        if let personal_url = lenderDic.valueForKey("personal_url") as? String {
            self.personal_url = personal_url
        }
        
        if let country_code = lenderDic.valueForKey("country_code") as? String {
            self.country_code = country_code
        }
        
        if let loan_count = lenderDic.valueForKey("loan_count") as? Int {
            self.loan_count = loan_count
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}