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
    
    override func awakeFromNib() {
        self.applyStyle()
    }
    
    func applyStyle() {
        let fontFD08 = KivaFontsAndColors.fontFaceOfFD08()
        let fontFD02 = KivaFontsAndColors.fontFaceOfFD02()
        let fontFC03 = KivaFontsAndColors.fontFaceOfFC03()
        let colorCA2 = KivaFontsAndColors.colorCA2()
        let colorCA3 = KivaFontsAndColors.colorCA3()
        let colorCC6 = KivaFontsAndColors.colorCC6()
        if let nameLabel = self.borrowerNameLabel {
            nameLabel.font = fontFD08
            nameLabel.textColor = colorCC6
        }
        if let countryLabel = self.borrowerCountryLabel {
            countryLabel.font = fontFD02
            countryLabel.textColor = colorCC6
        }
        if let sectorLabel = self.loanSectorLabel {
            sectorLabel.font = fontFD02
            sectorLabel.textColor = colorCC6
        }
        if let amountLabel = self.amountLabel {
            amountLabel.font = fontFD08;
            amountLabel.textColor = colorCA2
        }
        if let progress = self.fundedProgressView {
            progress.progressTintColor = colorCA2
        }
        if let remainingLabel = self.remainingLabel {
            remainingLabel.font = fontFC03
            remainingLabel.textColor = colorCA3
        }
    }
}


