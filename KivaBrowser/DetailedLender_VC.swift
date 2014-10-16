//
//  DetailedLender_VC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/13/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class DetailedLender_VC: UIViewController, UIScrollViewDelegate, UITextViewDelegate{
    var lender: Lender?
    
    func setLender(lender: Lender) {
        self.lender = lender
    }
    
}