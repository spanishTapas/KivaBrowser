//
//  DetailedLoanVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 9/15/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class DetailedLoanVC: UIViewController, LoanManagerDelegate, UIScrollViewDelegate, UITextViewDelegate  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var fundedAmountLabel: UILabel!
    @IBOutlet weak var disbursalDateLabel: UILabel!
    @IBOutlet weak var repaymentLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var currencyLossLabel: UILabel!
    @IBOutlet weak var protectionLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    let loanManager: LoanManager
    var detailedLoan: DetailedLoan?
    var loan_id: Int
    
    required init(coder aDecoder: NSCoder) {
        self.loanManager = LoanManager()
        self.loan_id = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loan Details"
        
        loanManager.fetcher = JsonDataFetcher()
        loanManager.fetcher!.delegate = loanManager
        loanManager.delegate = self
        
        self.scrollView.delegate = self
        self.descriptionView.delegate = self
        
        loanManager.fetchDetailedLoanByID(self.loan_id)
    }
    
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
    
            self.scrollView.layoutIfNeeded()
            self.scrollView.contentSize = self.contentView.bounds.size
        
            //println("self.scrollView = \(scrollView)")
            //println("self.scrollView bound size = \(NSStringFromCGSize(self.scrollView.frame.size))")
            //println("self.scrollView frame size = \(NSStringFromCGSize(self.scrollView.bounds.size))")
            //println("scrollView.contentSize= \(NSStringFromCGSize(self.scrollView.contentSize))")
            //println("self.contentView.bounds.size=\(NSStringFromCGSize(self.contentView.bounds.size))");
            let bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.height)
            //println("bottomOffset=\(bottomOffset)")
            self.scrollView.setContentOffset(bottomOffset, animated: true)
        }
    
    func setLoan_id(loan_id: Int) {
        self.loan_id = loan_id
        println("Detailedloan self.loan_id: \(self.loan_id)")
    }
    
    //#pragma mark - LoanManagerDelegate
    func didReceiveDetailedLoan(detailedLoan: DetailedLoan) {
        self.detailedLoan = detailedLoan
        self.setupViewForLoan(self.detailedLoan!)
    }
    
    func setupViewForLoan(detailedLoan: DetailedLoan) {
        //setup imageView
        if detailedLoan.img_id != nil {
            self.squareImageOfDetailedLoanForImageView(detailedLoan, imgView: self.photoView)
        }
        
        self.nameLabel.text = "\(detailedLoan.name)"
        //println("DetailedLoanVC setupViewForLoan...\(detailedLoan.name)")
        
        self.sectorLabel.text = "\(detailedLoan.sector)"
        
        var locaStr: NSAttributedString
        var townStr: NSMutableAttributedString
        var countryStr: NSMutableAttributedString
        let townAttr: Dictionary = [NSFontAttributeName: UIFont.systemFontOfSize(12)]
        let countryAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(13)]
        townStr = NSMutableAttributedString(string: "\(detailedLoan.town)\n", attributes: townAttr)
        countryStr = NSMutableAttributedString(string: detailedLoan.country, attributes: countryAttr)
        if detailedLoan.town.isEmpty {
            locaStr = countryStr
        } else {
            townStr.appendAttributedString(countryStr)
            locaStr = townStr
        }
        self.locationLabel.attributedText = locaStr
        
        if detailedLoan.status == "fundraising" {
            let statusAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15), NSForegroundColorAttributeName: UIColor.orangeColor()]
            let statusStr = NSMutableAttributedString(string: detailedLoan.status, attributes: statusAttr)
            self.statusLabel.attributedText = statusStr
        } else {
            let statusAttr: Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
            let statusStr = NSMutableAttributedString(string: detailedLoan.status, attributes: statusAttr)
            self.statusLabel.attributedText = statusStr
        }
        
        let useStr = "A loan of $\(detailedLoan.loan_amount) helps \(detailedLoan.name) \(detailedLoan.use)"
        self.useLabel.text = useStr
        
        self.descriptionView.text = detailedLoan.descText
        
        self.loanAmountLabel.text = "Requested: $ \(detailedLoan.loan_amount)"
        
        self.fundedAmountLabel.text = "Funded Amount: $ \(detailedLoan.funded_amount)"
        
        self.disbursalDateLabel.text = "Disbursal Date: \(detailedLoan.disbursal_date)"
        
        self.repaymentLabel.text = "Repayment Terms: \(detailedLoan.repay_term)"
        
        self.dueDateLabel.text = "Scheduled Due Date: \(detailedLoan.due_date)"
        
        self.currencyLossLabel.text = "Currency Exchange Loss: \(detailedLoan.currency_loss)"
        
        self.protectionLabel.text = "Default Protection: \(detailedLoan.protection)"
    }
    
    func squareImageOfDetailedLoanForImageView(detailedLoan: DetailedLoan, imgView: UIImageView) {
        
        let imageURL = detailedLoan.urlForImageFormat(detailedLoan.img_id!, format: Loan.KivaImageFormat.KivaImageFormatSquare)
        let imageFetchQ: dispatch_queue_t = dispatch_queue_create("image fetcher", nil)
        dispatch_async(imageFetchQ, {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true//not good
            let imageData: NSData = NSData(contentsOfURL: imageURL) //could take a while
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false//not good
            // UIImage is one of the few UIKit objects which is thread-safe, so we can do this here
            let image: UIImage = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                imgView.image = image
            })
            
        })
    }

    
}