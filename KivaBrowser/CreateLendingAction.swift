//
//  CreateLendingAction.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/17/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension LendingAction {
    //to convert raw JSON data into an array of LendingAction objects.
    class func LendingActionArrayFromJsonData(data: NSData, error: NSErrorPointer) -> [LendingAction]? {
        //parse out JSON data
        var lendingActionArr = [LendingAction]()
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json data: \(reason)")
        }else if let jsonDic = parsedObj as? NSDictionary {
            println("LendingAction, Json comes back as a Dictionary")
            if let lending_actions = jsonDic.valueForKey("lending_actions") as? [NSDictionary] {
                println("CreateLendingActions, lending_actions.count =\(lending_actions.count)")
                //We loop through the lending_actions and look into each NSDictionary inside it. We then create a LendingAction object and fill it with the necessary information, then adding it to the mutable array.
                for lendingActionDic in lending_actions {
                    let lending_action: LendingAction = self.createLendingActionFrom(lendingActionDic)
                    
                    lendingActionArr.append(lending_action)
                    
                }
                return lendingActionArr
            }
        }else if let lendingActionArr = parsedObj as? NSArray {
            println("LendingAction...Json comes back as an Array.")
        }
        return nil
    }
    
    class func createLendingActionFrom(lendingActionDic: NSDictionary) ->  LendingAction {
        let lending_action = LendingAction(lendingActionDic: lendingActionDic)
        return lending_action
    }
    
}