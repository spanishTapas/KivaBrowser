//
//  LendingActionCell.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/17/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class LendingActionCell :UITableViewCell {
    
    @IBOutlet weak var borrowerImage: UIImageView!
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var borrowerCountryLabel: UILabel!
    @IBOutlet weak var loanSectorLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var fundedProgressView: UIProgressView!
    @IBOutlet weak var remainingLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}