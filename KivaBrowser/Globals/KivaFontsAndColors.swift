//
//  KivaFontsAndColors.swift
//  KivaBrowser
//
//  Created by wanming zhang on 5/15/15.
//  Copyright (c) 2015 wanming zhang. All rights reserved.
//

import UIKit

class KivaFontsAndColors: NSObject {

//    #define RGB(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//    #define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
    
    //# pragma mark - Custom Fonts
    /**
    *  UIFont does not contain/maintain any color information
    HelveticaNeue-Bold,
    HelveticaNeue-CondensedBlack,
    HelveticaNeue-Medium,
    HelveticaNeue,
    HelveticaNeue-Light,
    HelveticaNeue-CondensedBold,
    HelveticaNeue-LightItalic,
    HelveticaNeue-UltraLightItalic,
    HelveticaNeue-UltraLight,
    HelveticaNeue-BoldItalic,
    HelveticaNeue-Italic
    **/
    class func dumpAllFonts() {
        for familyName in UIFont.familyNames() {
            for fontName in UIFont.fontNamesForFamilyName(familyName as! String){
                println(fontName)
            }
        }
    }
    /**
    * HelveticaNeue-Italic
    * HelveticaNeue-Bold
    * HelveticaNeue-UltraLight
    * HelveticaNeue-CondensedBlack
    * HelveticaNeue-BoldItalic
    * HelveticaNeue-CondensedBold
    * HelveticaNeue-Medium
    * HelveticaNeue-Light
    * HelveticaNeue-Thin
    * HelveticaNeue-ThinItalic
    * HelveticaNeue-LightItalic
    * HelveticaNeue-UltraLightItalic
    * HelveticaNeue-MediumItalic
    * HelveticaNeue
    **/
    
    //F-A01 Helvetica Neue, med 17, C-C6
    class func fontFaceOfFA01() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue-Medium", size: 17)!
        return font
    }
    
    //F-A02 Helvetica Neue, reg 17, C-A1
    class func fontFaceOfFA02() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue", size: 17)!
        return font
    }

    
    //F-A03 Helvetica Neue, reg 17, C-A3
    class func fontFaceOfFA03() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue", size: 17)!
        return font
    }
    
    //F-B01 Helvetica Neue, reg 11, C-A1
    class func fontFaceOfFB01() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue", size: 11)!
        return font
    }
    
    //F-B02 Helvetica Neue, reg 11, C-C4
    class func fontFaceOfFB02() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue", size: 11)!
        return font
    }
    
    //F-B03 Helvetica Neue, med 11, C-A6
    class func fontFaceOfFB03() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue-Medium", size: 11)!
        return font
    }
    
    //F-B04 Helvetica Neue, reg 17, C-A6
    class func fontFaceOfFB04() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "HelveticaNeue", size: 17)!
        return font
    }
    
    /**
    * MyriadSetPro-Medium
    * MyriadSetPro-Semibold
    * MyriadSetPro-Text
    * MyriadSetPro-UltralightItalic
    * MyriadSetPro-BoldItalic
    * MyriadSetPro-Ultralight
    * MyriadSetPro-Thin
    * MyriadSetPro-TextItalic
    * MyriadSetPro-MediumItalic
    * MyriadSetPro-SemiboldItalic
    * MyriadSetPro-Bold
    * MyriadSetPro-ThinItalic
    **/
    
    //F-C01 Myriad Set Pro, semibold 14, C-A6
    class func fontFaceOfFC01() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Semibold", size: 14)!
        return font
    }
    
    //F-C02 Myriad Set Pro, semibold 15, C-C6
    class func fontFaceOfFC02() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Semibold", size: 15)!
        return font
    }
    //F-C03 Myriad Set Pro, semibold 16, C-A4, All Caps
    class func fontFaceOfFC03() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Semibold", size: 16)!
        return font
    }
    //F-C04 Myriad Set Pro, bold 15, C-A6, All Caps
    class func fontFaceOfFC04() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Bold", size: 15)!
        return font
    }
    //F-D01 Myriad Set Pro, medium 15, C-C4, All Caps
    class func fontFaceOfFD01() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }
    
    //F-D02 Myriad Set Pro, text 18, C-C6
    class func fontFaceOfFD02() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Text", size: 18)!
        return font
    }

    //F-D03 Myriad Set Pro, medium 16, C-A6
    class func fontFaceOfFD03() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 16)!
        return font
    }

    //F-D04 Myriad Set Pro, medium 15, C-C4
    class func fontFaceOfFD04() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }

    //F-D05 Myriad Set Pro, text 17, C-C6
    class func fontFaceOfFD05() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Text", size: 17)!
        return font
    }

    //F-D06 Myriad Set Pro, medium 16, C-C6
    class func fontFaceOfFD06() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 16)!
        return font
    }

    //F-D07 Myriad Set Pro, medium 13, C-C4
    class func fontFaceOfFD07() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 13)!
        return font
    }

    //F-D08 Myriad Set Pro, semibold 19, C-C6
    class func fontFaceOfFD08() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Semibold", size: 19)!
        return font
    }

    //F-D09 Myriad Set Pro, medium 15, C-C6
    class func fontFaceOfFD09() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }

    //F-D10 Myriad Set Pro, medium 15, C-C3
    class func fontFaceOfFD10() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }
    
    //F-D11 Myriad Set Pro, medium 32, C-C6
    class func fontFaceOfFD11() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 32)!
        return font
    }
    
    //F-D12 Myriad Set Pro, thin 38, C-A6
    class func fontFaceOfFD12() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Thin", size: 38)!
        return font
    }
    
    //F-D13 Myriad Set Pro, medium 15, C-C4
    class func fontFaceOfFD13() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }
    
    //F-D14 Myriad Set Pro, medium 15, C-A1
    class func fontFaceOfFD14() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 15)!
        return font
    }
    
    //F-D15 Myriad Set Pro, medium 17, C-C4
    class func fontFaceOfFD15() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 17)!
        return font
    }
    
    //F-D16 Myriad Set Pro, medium 17, C-A1
    class func fontFaceOfFD16() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 17)!
        return font
    }
    
    //F-D17 Myriad Set Pro, medium 17, C-A6
    class func fontFaceOfFD17() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 17)!
        return font
    }
    
    //F-D22 Myriad Set Pro, bold 14, C-A6
    class func fontFaceOfFD22() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Bold", size: 14)!
        return font
    }
    class func fontFaceOfFD22Medium() -> UIFont {
        var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        font = UIFont(name: "MyriadSetPro-Medium", size: 14)!
        return font
    }
    
    //#pragma mark - Custom Colors
    class func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    class func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //C-A1(52,170,202) blue
    class func colorCA1() -> UIColor {
        return KivaFontsAndColors.RGB(52.0, g: 170.0, b: 202.0)
    }

    //C-A2(73,207,149) green
    class func colorCA2() -> UIColor {
        return KivaFontsAndColors.RGB(73.0, g: 207.0, b: 149.0)
    }
 
    //C-A3(240,114,68) orange
    class func colorCA3() -> UIColor {
        return KivaFontsAndColors.RGB(240.0, g: 114.0, b: 68.0)
    }
    
    //C-A4(218,72,68) red
    class func colorCA4() -> UIColor {
        return KivaFontsAndColors.RGB(218.0, g: 72.0, b: 68.0)
    }
    //C-A5(254,213,90) yellow
    class func colorCA5() -> UIColor {
        return KivaFontsAndColors.RGB(254.0, g: 213.0, b: 90.0)
    }
    //C-A6(255,255,255) white
    class func colorCA6() -> UIColor {
        return KivaFontsAndColors.RGB(255.0, g: 255.0, b: 255.0)
    }
    //C-A7(0,0,0) black
    class func colorCA7() -> UIColor {
        return KivaFontsAndColors.RGB(0.0, g: 0.0, b: 0.0)
    }
    
    //C-B1(228, 240, 250) pale blue
    class func colorCB1() -> UIColor {
        return KivaFontsAndColors.RGB(228.0, g: 240.0, b: 250.0)
    }
    
    //C-B2(247, 240, 236)
    class func colorCB2() -> UIColor {
        return KivaFontsAndColors.RGB(247.0, g: 240.0, b: 236.0)
    }

    //C-B3(247, 235, 232)
    class func colorCB3() -> UIColor {
        return KivaFontsAndColors.RGB(247.0, g: 235.0, b: 232.0)
    }

    //C-B4(243, 234, 231)
    class func colorCB4() -> UIColor {
        return KivaFontsAndColors.RGB(243.0, g: 234.0, b: 231.0)
    }
    
    //C-B5(232, 217, 201)
    class func colorCB5() -> UIColor {
        return KivaFontsAndColors.RGB(232.0, g: 217.0, b: 201.0)
    }

    //C-B6(248, 183, 143)
    class func colorCB6() -> UIColor {
        return KivaFontsAndColors.RGB(248.0, g: 183.0, b: 143.0)
    }
    
    //light to dark gray
    //C-C1(243,247,247)
    class func colorCC1() -> UIColor {
        return KivaFontsAndColors.RGB(243.0, g: 247.0, b: 247.0)
    }
    //C-C2(234,237,230)
    class func colorCC2() -> UIColor {
        return KivaFontsAndColors.RGB(234.0, g: 237.0, b: 230.0)
    }
    
    //C-C3(197,199,183)
    class func colorCC3() -> UIColor {
        return KivaFontsAndColors.RGB(197.0, g: 199.0, b: 183.0)
    }

    //C-C4(144,146,133)
    class func colorCC4() -> UIColor {
        return KivaFontsAndColors.RGB(144.0, g: 146.0, b: 133.0)
    }

    //C-C5(89,90,82)
    class func colorCC5() -> UIColor {
        return KivaFontsAndColors.RGB(85.0, g: 90.0, b: 82.0)
    }

    //C-C6(60,61,54)
    class func colorCC6() -> UIColor {
        return KivaFontsAndColors.RGB(60.0, g: 61.0, b: 54.0)
    }
}
