//
//  JsonDataFetcherDelegate.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/5/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

@objc protocol JsonDataFetcherDelegate {
    func receivedJsonData(data: NSData)
    func receivedDetailedLoanJson(jsonData: NSData)
    
    func fetchingDataFailedWithError(error: NSErrorPointer)
    
    func receivedPagingInfo(data: NSData)
    
    func receivedTeamJsonData(data: NSData)
    func receivedTeamPagingInfo(data: NSData)
    
    func receivedLenderJsonData(data: NSData)
    func receivedLenderPagingInfo(data: NSData)
    
    func receivedLending_ActionJsonData(data: NSData)
}