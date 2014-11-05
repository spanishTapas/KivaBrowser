//
//  DetailLendingAction_VC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/19/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class DetailLendingAction_VC: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lenderInfo: UILabel!
    @IBOutlet weak var lenderCount: UILabel!
    @IBOutlet weak var lenderImage: UIImageView!
    
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var loanAmount: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var borrowerInfo: UILabel!
    
    @IBOutlet weak var borrowerImage: UIImageView!
    @IBOutlet weak var use: UITextView!
    
    var lending_action: LendingAction?
    
    override func viewDidLoad() {
        self.title = "Lending_Action Details"
        self.scrollView.delegate = self
        self.use.delegate = self
    }
    override func viewWillAppear(animated: Bool) {
        if let lending_action = self.lending_action? {
            self.setupViewForLending_Action(lending_action)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = self.contentView.bounds.size
        let bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.height)
        //println("bottomOffset=\(bottomOffset)")
        self.scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    func setLending_Action(lending_action: LendingAction) {
        self.lending_action = lending_action
    }
    
    func setupViewForLending_Action(lending_action: LendingAction) {
        if let lender = lending_action.lender {
            let nameAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
            let nameStr = NSMutableAttributedString(string: "Lender: \(lender.name)", attributes: nameAttr)
    
            let locaAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.blueColor()]

            var location = ""
            if lender.whereabouts.isEmpty && lender.country_code.isEmpty {
                location = "\nLocation Unknown"
            } else {
                location = "\n\(lender.whereabouts) \(lender.country_code)"
            }
            let locaStr = NSMutableAttributedString(string: location, attributes: locaAttr)
            nameStr.appendAttributedString(locaStr)
            self.lenderInfo.attributedText = nameStr
            
            let imageURL = KivaImage.urlForImageFormat(lending_action.lender!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: lenderImage)
            
        }
        if let loan = lending_action.loan {
            let nameAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
            let nameStr = NSMutableAttributedString(string: "Borrower: \(loan.name)", attributes: nameAttr)
            
            if loan.lender_count <= 1 {
                self.lenderCount.text = "There is \(loan.lender_count) lender for this loan."
            } else {
                self.lenderCount.text = "There are \(loan.lender_count) lenders for this loan."
            }
            
            let locaAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.blueColor()]
            let locaStr = NSMutableAttributedString(string: "\n\(loan.country)", attributes: locaAttr)
            nameStr.appendAttributedString(locaStr)
            self.borrowerInfo.attributedText = nameStr
            
            let imageURL = KivaImage.urlForImageFormat(lending_action.loan!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: borrowerImage)
            
            let sectorAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
            let sectorStr = NSMutableAttributedString(string: "\(loan.sector)", attributes: sectorAttr)
            let activityAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.blueColor()]
            let activityStr = NSMutableAttributedString(string: "\n\(loan.activity)", attributes: activityAttr)
            sectorStr.appendAttributedString(activityStr)
            self.sectorLabel.attributedText = sectorStr
            
            self.use.text = "A loan of \(loan.amount) to help \(loan.name) \(loan.use)"
    
            self.loanAmount.text = "Loan_Request: $ \(loan.amount)"
            
            let amount = loan.amount
            let funded = loan.funded_amount
            let remaining = amount - funded
            let progress = float_t(funded)/float_t(amount)
            self.progressView.progress = progress
            self.progressView.progressTintColor = UIColor.greenColor()
            
            let fundedPercentage = progress * 100
            let percentageStr = "\(Int(fundedPercentage))% funded"
            let remainingStr = "$\(remaining) to go!"
            self.progressLabel.text = "\(percentageStr)\n\(remainingStr)"
        }
    }
}