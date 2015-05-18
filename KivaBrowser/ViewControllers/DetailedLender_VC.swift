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
    
    @IBOutlet weak var lenderImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var loanCountLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var loanBecauseTextView: UITextView!
    var lender: Lender?
    
    override func viewDidLoad() {
        self.title = "Latest Lenders"
    }
    override func viewWillAppear(animated: Bool) {
        if let lender = self.lender {
            self.setupViewForLender(lender)
        }
    }
    func setLender(lender: Lender) {
        self.lender = lender
    }
    
    func setupViewForLender(lender: Lender) {
        //setup imageView
        if lender.imgDic != nil {
            let imageURL = KivaImage.urlForImageFormat(lender.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: lenderImage)
        }
        
        self.nameLabel.text = "\(lender.name)"
        
        if lender.whereabouts.isEmpty && lender.country_code.isEmpty {
            self.locationLabel.text = "Location Unknown"
        } else {
            self.locationLabel.text = "\(lender.whereabouts)\n\(lender.country_code)"
        }
        if lender.loan_count != nil  {
            self.loanCountLabel.text = "Loan Count: \(lender.loan_count)"
        } else {
            self.loanCountLabel.text = "Loan Count: 0"
        }
        if lender.member_since.isEmpty {
            self.memberSinceLabel.text = "Member Since: N/A"
        } else {
            self.memberSinceLabel.text = "Member Since: \(lender.member_since)"
        }
        if lender.occupation.isEmpty && lender.occupational_info.isEmpty {
            self.occupationLabel.text = "Occupation: N/A"
        } else if !lender.occupation.isEmpty {
            self.occupationLabel.text = lender.occupation
        } else if !lender.occupational_info.isEmpty {
            self.occupationLabel.text = lender.occupational_info
        }
        if lender.personal_url.isEmpty {
            self.urlLabel.text = "Personal_URL: N/A"
        } else {
            self.urlLabel.text = "Personal_URL: \(lender.personal_url)"
        }
        if !lender.loan_because .isEmpty {
            self.loanBecauseTextView.text = "Loan_because: \(lender.loan_because)"
        } else {
            self.loanBecauseTextView.text = "Loan_because: N/A"
        }
        
    }
    
}