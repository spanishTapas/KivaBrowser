//
//  KivaImage.swift
//  KivaBrowser
//
//  Created by wanming zhang on 10/18/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import Foundation
import UIKit

class KivaImage {
    
    class func urlStringForKivaImage(imgDic: NSDictionary, format: KivaImageFormat) -> String {
        let img_id: Int = imgDic.valueForKey("id") as Int
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
    
    class func urlForImageFormat (imgDic: NSDictionary, format:KivaImageFormat) -> NSURL {
        let urlString = self.urlStringForKivaImage(imgDic, format: format)
        return NSURL(string: urlString)!
    }

    class func squareImageOfURLForImageView(imageURL: NSURL, imgView: UIImageView) {
        
        //let imageURL = KivaImage.urlForImageFormat(lending_action.loan!.imgDic!, format: KivaImageFormat.KivaImageFormatSquare)
        
        let imageFetchQ: dispatch_queue_t = dispatch_queue_create("image fetcher", nil)
        dispatch_async(imageFetchQ, {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true//not good
            let imageData: NSData = NSData(contentsOfURL: imageURL)!//could take a while
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false//not good
            // UIImage is one of the few UIKit objects which is thread-safe, so we can do this here
            let image: UIImage = UIImage(data: imageData)!
            dispatch_async(dispatch_get_main_queue(), {
                imgView.image = image
            })
            
        })
    }
    

}