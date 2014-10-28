//
//  AboutKivaBrowser.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/21/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class AboutKivaBrowser: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var aboutKivaBrowser: UITextView!
    @IBOutlet weak var aboutKivaOrg: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AboutKivaBrowser"
        self.automaticallyAdjustsScrollViewInsets = false
        self.setupAboutKivaBrowser()
        self.setupAboutKivaOrg()
    }
    
    
    func setupAboutKivaBrowser() {
        var kivaBrowserText = "KivaBrowser is an iOS client for kiva.org. KivaBrowser makes it easy to explore microfinance via the Kiva API. You can browse the latest lending_actions and loan_requests; browse loans, lending_teams, and lenders by different orders; and filter search results by customized criteria.\n"
        kivaBrowserText += "\nKivaBrowser is not built or endorsed by kiva.org."
        
        let headerAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
        let headerStr = NSMutableAttributedString(string: "About KivaBrowser\n\n", attributes: headerAttr)
        let bodyAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        let bodyStr = NSMutableAttributedString(string: kivaBrowserText, attributes: bodyAttr)
        headerStr.appendAttributedString(bodyStr)
        self.aboutKivaBrowser.attributedText = headerStr
    }
    
    func setupAboutKivaOrg() {
    
        let kivaOrgText = "Kiva.org is a non-profit organization with a mission to connect people through lending to alleviate poverty. Leveraging the internet and a worldwide network of microfinance institutions, Kiva lets individuals lend as little as $25 to help create opportunity around the world."
        let headerAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
        let headerStr = NSMutableAttributedString(string: "About Kiva.org\n\n", attributes: headerAttr)
        let bodyAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        let bodyStr = NSMutableAttributedString(string: kivaOrgText, attributes: bodyAttr)
        headerStr.appendAttributedString(bodyStr)
        self.aboutKivaOrg.attributedText = headerStr
    }
}