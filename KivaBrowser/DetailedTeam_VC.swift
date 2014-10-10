//
//  DetailedTeam_VC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/8/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class DetailedTeam_VC: UIViewController, UIScrollViewDelegate, UITextViewDelegate  {
    var team: Team?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var teamSinceLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var loanCountLabel: UILabel!
    @IBOutlet weak var loanedAmountLabel: UILabel!
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var URLButton: UIButton!
    @IBOutlet weak var loanBecauseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Details"
        
        self.scrollView.delegate = self
        self.descriptionTextView.delegate = self
        self.loanBecauseTextView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if let team = self.team? {
            self.setupViewForToan(team)
        }
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
    
    func setTeam(team: Team) {
        self.team = team
    }
    
    @IBAction func urlButtonPressed(sender: UIButton) {
        if let urlStr = team?.website_url {
            let url = NSURL(string: urlStr)
            UIApplication.sharedApplication().openURL(url)
        }
    }

    
    func setupViewForToan(team: Team) {
        //setup imageView
        if team.imgDic != nil {
            self.squareImageOfTeamForImageView(team, imgView: teamImage)
        }
        
        self.nameLabel.text  = team.name
        self.shortNameLabel.text = team.shortname
        let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15), NSForegroundColorAttributeName: UIColor.blueColor()]
        let categoryStr = NSMutableAttributedString(string: team.category, attributes: attributes)
        self.categoryLabel.attributedText = categoryStr
        
        if team.whereabouts != "" {
            self.locationLabel.text = "\(team.whereabouts)"
        } else {
            self.locationLabel.text = "Location N/A"
        }
        
        self.membershipLabel.text = "Membership \(team.membership_type)"
        
        self.descriptionTextView.text = "Description: \(team.description)"
        
        self.teamSinceLabel.text = "Team Since: \(team.team_since)"
        self.memberCountLabel.text = "Members: \(team.member_count)"
        self.loanCountLabel.text = "Loan Count: \(team.loan_count)"
        self.loanedAmountLabel.text = "Loaned Amount: \(team.loaned_amount)"
        
        
        if team.website_url != "" {
            self.URLButton.setTitle("\(team.website_url)", forState: UIControlState.Normal)
        } else {
            self.URLButton.setTitle("Website N/A", forState: UIControlState.Normal)
        }
        self.loanBecauseTextView.text = "Loan because: \(team.loan_because)"
    }
    
    func squareImageOfTeamForImageView(team: Team, imgView: UIImageView) {
        
        let imageURL = team.urlForImageFormat(team.imgDic!, format:
            Team.KivaImageFormat.KivaImageFormatSquare)
        
        let imageFetchQ: dispatch_queue_t = dispatch_queue_create("image fetcher", nil)
        dispatch_async(imageFetchQ, {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true//not good
            let imageData: NSData = NSData(contentsOfURL: imageURL)//could take a while
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false//not good
            // UIImage is one of the few UIKit objects which is thread-safe, so we can do this here
            let image: UIImage = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                imgView.image = image
            })
            
        })
    }

}