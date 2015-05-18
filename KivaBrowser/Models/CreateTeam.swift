//
//  CreateTeam.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/3/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension Team {
    //to convert raw JSON data into an array of Team objects.
    class func TeamArrayFromJsonData(data: NSData, error: NSErrorPointer) -> [Team]? {
        //parse out JSON data
        var teamArr = [Team]()
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json data: \(reason)")
        }else if let jsonDic = parsedObj as? NSDictionary {
            println("Json comes back as a Dictionary")
            if let teams = jsonDic.valueForKey("teams") as? [NSDictionary] {
                //println("in CreateLoan, \(loans.count) loans")
                //We loop through the loans and look into each NSDictionary inside it. We then create a Loan object and fill it with the necessary information, then adding it to the mutable array.
                for teamDic in teams {
                    let team: Team = self.createTeamFrom(teamDic)
                    
                    teamArr.append(team)
                    
                }
                return teamArr
            }
        }else if let teamArr = parsedObj as? NSArray {
            println("Team...Json comes back as an Array.")
        }
        return nil
    }
    
    class func createTeamFrom(teamDic: NSDictionary) ->  Team {
        let team = Team(teamDic: teamDic)
        return team
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