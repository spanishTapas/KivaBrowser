//
//  TeamWebView.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/10/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class TeamWebView: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var teamWebView: UIWebView!
    var websiteURL: NSURL?
    var shortName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = self.shortName {
            self.title = "Team \"\(name)\" Website"
        }
        if let url = self.websiteURL {
            self.loadWebsite(url)
        }
        
    }
    
    func loadWebsite(url: NSURL) {
        let loadQ: dispatch_queue_t = dispatch_queue_create("Website Load", nil)
        dispatch_async(loadQ, {
            let request: NSURLRequest = NSURLRequest(URL: url)
            self.teamWebView.scalesPageToFit = true
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.teamWebView.loadRequest(request)
            
            if self.teamWebView.loading == false {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            }
        })

    }
    
    func setTeamURL(url: NSURL) {
        self.websiteURL = url
    }
    
    func setShortName(shortName: String) {
        self.shortName = shortName
    }
}