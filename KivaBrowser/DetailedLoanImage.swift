//
//  DetailedLoanImage.swift
//  KivaBrowser
//
//  Created by wanming zhang on 8/29/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension DetailedLoan {
    
    func urlStringForDetailedLoan(img_id: Int, format: Loan.KivaImageFormat) -> String {
        let fileType = "jpg"
        var formatStr: String
        var height = 0, width = 0
        switch format {
        case .KivaImageFormatSquare:
            formatStr = "s300"
        case .KivaImageFormatSpecifyBoth:
            formatStr = "\(height)w\(width)"
        case .KivaImageFormatFullSize:
            formatStr = "fullsize";
        }
        
        var urlStr = "http://www.kiva.org/img/"
        urlStr += (formatStr + "/" + "\(img_id)." + fileType)
        return urlStr

    }
    
    func urlForImageFormat (img_id: Int, format:Loan.KivaImageFormat) -> NSURL {
        let urlString = self.urlStringForDetailedLoan(img_id, format: format)
        return NSURL(string: urlString)
    }

}