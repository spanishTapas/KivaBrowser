//
//  LenderImage.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/13/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation

extension Lender {
    func urlStringForTeam(imgDic: NSDictionary, format: KivaImageFormat) -> String {
        let img_id: Int = imgDic.valueForKey("id") as! Int
        let fileType = "jpg"
        var formatStr: String
        var height = 0, width = 0
        switch format {
        case .KivaImageFormatSquare:
            formatStr = "s300"
        case .KivaImageFormatSpecifyBoth:
            formatStr = "\(height)w\(width)"
        case .KivaImageFormatFullSize:
            formatStr = "fullsize"
        }
        //http://www.kiva.org/img/w200h200/181707.jpg
        //"http://www.kiva.org/img/%@/%@.%@",formatStr,img_id,fileType
        var urlStr = "http://www.kiva.org/img/"
        urlStr += (formatStr + "/" + "\(img_id)." + fileType)
        return urlStr
    }
    
    func urlForImageFormat (imgDic: NSDictionary, format:KivaImageFormat) -> NSURL {
        let urlString = self.urlStringForTeam(imgDic, format: format)
        return NSURL(string: urlString)!
    }
}