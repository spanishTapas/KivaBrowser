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
    var website_url: NSURL?
    var shortName: String?

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
        if let name = team?.shortname {
            self.shortName = name
            self.title = "\"\(name)\" Details"
        }
        
        self.scrollView.delegate = self
        self.descriptionTextView.delegate = self
        self.loanBecauseTextView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if let team = self.team? {
            self.setupViewForTeam(team)
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
    
    func setupViewForTeam(team: Team) {
        //setup imageView
        
        if team.imgDic != nil {
            let imageURL = KivaImage.urlForImageFormat(team.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
            KivaImage.squareImageOfURLForImageView(imageURL, imgView: teamImage)
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
            self.website_url = NSURL(string: team.website_url)
        } else {
            self.URLButton.setTitle("Website N/A", forState: UIControlState.Normal)
        }
        self.loanBecauseTextView.text = "Loan because: \(team.loan_because)"
    }
    
    @IBAction func urlButtonPressed(sender: AnyObject) {
        if self.website_url != nil {
            performSegueWithIdentifier("ShowTeamWebView", sender: sender)
        }
    }
    
    //#pragma mark - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if sender is UIButton {
            if segue.identifier == "ShowTeamWebView" {
                let TWV = segue.destinationViewController as TeamWebView
                TWV.setTeamURL(self.website_url!)
                if shortName != nil {
                TWV.setShortName(shortName!)
                }
            }
        }
    }
    
}