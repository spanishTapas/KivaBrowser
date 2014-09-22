//
//  Paginator.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/8/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

class Paginator: NSObject {
    var pagingDic: NSDictionary?
    var pages: Int?
    var total: Int?
    var page_size: Int?
    
    var reachedLastPage: Bool
    
    class func paginatorFromJsonData(data: NSData, error: NSErrorPointer) -> Paginator {
        //parse out JSON data
        let aPaginator: Paginator = Paginator()
        var localError: NSError?
        var parsedObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let actualError = localError {
            let reason: String? = actualError.localizedDescription
            println("Error parsing json pagination data: \(reason)")
        }
        
        //look inside the paging dictionary
        if let jsonDic = parsedObj as? NSDictionary {
            println("paginator parsedObj comes back as a Dictionary")
            if let pagingDic = jsonDic.valueForKey("paging") as? NSDictionary {
                aPaginator.pages = pagingDic.valueForKey("pages") as? Int
                aPaginator.total = pagingDic.valueForKey("total") as? Int
                aPaginator.page_size = pagingDic.valueForKey("page_size") as? Int
            }
        } else if let jsonArr = parsedObj as? NSArray {
            println("paginator parsedObj comes back as an Array")
        }
        return aPaginator
    }
    
    override init() {
        self.reachedLastPage = false
    }
    
}