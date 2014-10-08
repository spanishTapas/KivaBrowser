//
//  Teams_TVC.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/2/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class Teams_TVC: UITableViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, LoanManagerDelegate{
    let loanManager: LoanManager
    
    var teamArray = [Team]()
    var searchResultsArray = [Team]()
    
    var sortByStr: String = ""
    var isLoading: Bool
    var currPageNum: Int
    var paginator: Paginator
    
    required init(coder aDecoder: NSCoder) {
        
        self.loanManager = LoanManager()
        self.paginator = Paginator()
        self.currPageNum = 1
        self.isLoading = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loanManager.fetcher = JsonDataFetcher()
        loanManager.fetcher!.delegate = loanManager
        loanManager.delegate = self
        
        //self.searchDisplayController?.searchResultsTableView.registerClass(LoanCell.self, forCellReuseIdentifier: "LoanCell")
        
        self.loadTeamsForPage(1)
        self.loanManager.fetchTeamPagingInfoBy(self.sortByStr)
    }
    
    func setsortByStr(sortByStr: String) {
        self.sortByStr = sortByStr
    }
    //#pragma mark - set Model
    func loadTeamsForPage(pageNum: Int) {
        self.loanManager.fetchTeamsBy(self.sortByStr, pageNum: pageNum)
    }
    
    //LoanManagerDelegate
    func didReceiveTeams(teams: [Team]) {
        if currPageNum == 1 {
            teamArray = teams as [Team]
        } else {
            self.teamArray += teams
        }
        self.isLoading = false
        self.tableView.reloadData()
    }
    
    func fetchingTeamsFailedWithError(error: NSErrorPointer) {
        
    }
    
    func reachedLastPage() -> Bool {
        //get paging Dictionary for this search
        return self.currPageNum >= self.paginator.pages
    }
    
    //LoanManagerDelegate
    func didReceiveTeamPagingInfo(paginator: Paginator) {
        self.paginator = paginator
        println("Teams_TVC paginator.pages: \(self.paginator.pages)")
    }

    //pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1;
    }
    
    // lets the UITableView know how many rows it should display
    // in this case, just the count of dictionaries in the Model's array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController?.searchResultsTableView {
            //println("Loans_TVC tableView numberOfRowsInSection, searchResultsTableView...")
            let numberOfRows = searchResultsArray.count
            //println("numberOfRows = \(numberOfRows)")
            return numberOfRows
        } else {
            let numberOfRows = teamArray.count
            //println("Teams_TVC number of rows: \(numberOfRows)")
            return numberOfRows
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TeamCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as TeamCell
        if tableView == self.searchDisplayController?.searchResultsTableView {
            let team = searchResultsArray[indexPath.row] as Team
            self.configureCell(cell, team: team)
        } else {
            let team = teamArray[indexPath.row] as Team
            self.configureCell(cell, team: team)
        }
        return cell
    }
    
    func configureCell(cell: TeamCell, team: Team) {
        cell.nameLabel.text = team.name
        cell.categoryLabel.text = team.category
        cell.descriptionLabel.text = team.description
        
        if team.imgDic != nil {
            self.squareImageOfTeamForImageView(team, imgView: cell.teamImage)
        }
    }

    //#pragma mark - Table view delegate
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //set up label
        let footerView: UIView = UIView(frame: CGRectMake(0, 0, 400, 28))
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, 400, 28))
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = NSTextAlignment.Center
        
        if let pages = self.paginator.pages {
            let text: String = "\(self.currPageNum) out of \(pages) pages"
            println("\(text)")
            label.text = text
            println("\(label.text)")
        }
        
        footerView.addSubview(label)
        self.tableView.tableFooterView = footerView
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98.0
    }
    
    //#pragma mark - UIScrollViewDelegate Methods
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // when reaching bottom, load a new page
        let scrollViewHeight = scrollView.bounds.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if (scrollOffset + scrollViewHeight >= scrollContentSizeHeight) {
            if self.isLoading == false {
                self.isLoading = true
                if (!self.reachedLastPage()) {
                    self.loadTeamsForPage(++self.currPageNum)
                }
            }
        }
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