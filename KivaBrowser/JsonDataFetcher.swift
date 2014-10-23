//
//  JsonDataFetcher.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/4/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class JsonDataFetcher {
    
    // JsonDataFetcherDelegate
    weak var delegate: JsonDataFetcherDelegate?
    
    let kBGQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) // a background queue

    func kivaDataFromURL(url: NSURL, error: NSErrorPointer) -> NSData? {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let data: NSData? = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error: error)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        return data;
    }

    func fetchRecentLending_Actions() {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            let dataStr: String = "http://api.kivaws.org/v1/lending_actions/recent.json"
            //println("JsonDataFetcher fetchLatestLoanData dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    // handle error
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedLending_ActionJsonData(data!)
                }
            })
        })
    }
    
    func fetchLatestLoanData(pageNum: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            let dataStr: String = "http://api.kivaws.org/v1/loans/search.json&page=\(pageNum)"
            //println("JsonDataFetcher fetchLatestLoanData dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    // handle error
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedJsonData(data!)
                }
            })
        })
    }
    
   
    func fetchLoansByRequest(requestStr: String, pageNum: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            //form data string by search criteria
            //search criteria by user selection
            var dataStr: String = "http://api.kivaws.org/v1/loans/search.json"
            var pathComp: String = "\(requestStr)"
            pathComp += "&page=\(pageNum)"
            dataStr = dataStr.stringByAppendingString(pathComp)
            //println("JsonDataFetcher fetchLoansByRequest dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                } else {
                    self.delegate?.receivedJsonData(data!)
                }
            })
            
        })
    }
    
    func getPagingInfo(){
        dispatch_async(kBGQueue, {
        var connectionError: NSError?
        let dataStr: String = "http://api.kivaws.org/v1/loans/search.json"
        let dataURL: NSURL = NSURL(string: dataStr)!
        let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    println("JsonDataFetcher... getPagingInfo")
                    self.delegate?.receivedPagingInfo(data!)
                }
                })
            
        })
    }
    
    func getPagingInfoByRequest(requestStr: String) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            //form data string by search criteria
            //search criteria by user selection
            var dataStr: String = "http://api.kivaws.org/v1/loans/search.json"
            let pathComp = requestStr
            dataStr = dataStr.stringByAppendingString(pathComp)
            let dataURL = NSURL(string: dataStr)
            
            let data: NSData? = self.kivaDataFromURL(dataURL!, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedPagingInfo(data!)
                }
            })
            
        })
    }
    
    func fetchDetailedLoanByID(loan_id: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            var dataStr: String = "http://api.kivaws.org/v1/loans/"
            dataStr = dataStr.stringByAppendingString("\(loan_id)")
            dataStr = dataStr.stringByAppendingString(".json")
            //println("JsonDataFetcher fetchDetailedLoanByID dataStr = \(dataStr)")
            let dataURL = NSURL(string: dataStr)
            let data: NSData? = self.kivaDataFromURL(dataURL!, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                } else {
                    self.delegate?.receivedDetailedLoanJson(data!)
                }
            })
        })
    }

    func fetchTeamsBy(sortByStr: String, pageNum: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            var dataStr: String = "http://api.kivaws.org/v1/teams/search.json"
            var pathComp: String = "\(sortByStr)"
            pathComp += "&page=\(pageNum)"
            dataStr = dataStr.stringByAppendingString(pathComp)
            println("JsonDataFetcher fetchTeamsBy dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    // handle error
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedTeamJsonData(data!)
                }
            })
        })
    }
    
    func getTeamPagingInfoSortedBy(sortByStr: String) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            //form data string by search criteria
            //search criteria by user selection
            var dataStr: String = "http://api.kivaws.org/v1/teams/search.json"
            let pathComp = sortByStr
            dataStr = dataStr.stringByAppendingString(pathComp)
            let dataURL = NSURL(string: dataStr)
            
            let data: NSData? = self.kivaDataFromURL(dataURL!, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedTeamPagingInfo(data!)
                }
            })
            
        })
    }

    func fetchLatestLendersData(pageNum: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            let dataStr: String = "http://api.kivaws.org/v1/lenders/newest.json&page=\(pageNum)"
            //println("JsonDataFetcher fetchLatestLenderData dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    // handle error
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedLenderJsonData(data!)
                }
            })
        })
    }
    
    func getLatestLendersPagingInfo() {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            let dataStr: String = "http://api.kivaws.org/v1/lenders/newest.json"
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    //println("JsonDataFetcher... getLatestLenderPagingInfo")
                    self.delegate?.receivedLenderPagingInfo(data!)
                }
            })
            
        })
    }
    
    func fetchLendersByRequest(requestStr: String, pageNum: Int) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            //form data string by search criteria
            //search criteria by string q
            var dataStr: String = "http://api.kivaws.org/v1/lenders/search.json"
            var pathComp: String = "\(requestStr)"
            pathComp += "&page=\(pageNum)"
            dataStr = dataStr.stringByAppendingString(pathComp)
            //println("JsonDataFetcher fetchLendersByRequest dataStr = \(dataStr)")
            let dataURL: NSURL = NSURL(string: dataStr)!
            let data: NSData? = self.kivaDataFromURL(dataURL, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                } else {
                    self.delegate?.receivedLenderJsonData(data!)
                }
            })
            
        })
    }
    
    func getLenderPagingInfoByRequest(requestStr: String) {
        dispatch_async(kBGQueue, {
            var connectionError: NSError?
            //form data string by search criteria
            //search criteria by string q
            var dataStr: String = "http://api.kivaws.org/v1/lenders/search.json"
            let pathComp = requestStr
            dataStr = dataStr.stringByAppendingString(pathComp)
            let dataURL = NSURL(string: dataStr)
            
            let data: NSData? = self.kivaDataFromURL(dataURL!, error: &connectionError)
            dispatch_async(dispatch_get_main_queue(), {
                if (connectionError != nil) {
                    self.delegate?.fetchingDataFailedWithError(&connectionError)
                }else {
                    self.delegate?.receivedLenderPagingInfo(data!)
                }
            })
            
        })

    }
    
    init() {
        
    }
}

