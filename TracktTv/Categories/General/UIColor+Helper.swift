//
//  UIColorExtension.swift
//  SOSMujer
//
//  Created by Arturo Gamarra on 12/13/15.
//  Copyright © 2015 Bennu.tv. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    // MARK: - Private
    private class func colorComponentFrom(str:String, start:Int, length:Int) -> CGFloat {
        let range = str.startIndex.advancedBy(start)..<str.startIndex.advancedBy(start+length)
        let substring = str.substringWithRange(range)
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent:CUnsignedInt = 0
        NSScanner(string: fullHex).scanHexInt(&hexComponent)
        return CGFloat(hexComponent)/255.0
    }
    
    // MARK: - Public
    public class func colorWithHexString(hexString:String) -> UIColor {
        return self.colorWithHexString(hexString, alpha: -1)
    }
    
    public class func colorWithHexString(hexString:String, alpha alphaParam:CGFloat) -> UIColor {
        let colorString = hexString.stringByReplacingOccurrencesOfString("#", withString: "")
        var alpha, red, blue, green:CGFloat
        switch(colorString.characters.count) {
        case 3: // #RGB
            alpha = 1.0
            red   = self.colorComponentFrom(colorString, start: 0, length: 1)
            green = self.colorComponentFrom(colorString, start: 1, length: 1)
            blue  = self.colorComponentFrom(colorString, start: 2, length: 1)
            break;
        case 4: // #ARGB
            alpha = self.colorComponentFrom(colorString, start: 0, length: 1)
            red   = self.colorComponentFrom(colorString, start: 1, length: 1)
            green = self.colorComponentFrom(colorString, start: 2, length: 1)
            blue  = self.colorComponentFrom(colorString, start: 3, length: 1)
            break;
        case 6: // #RRGGBB
            alpha = 1.0
            red   = self.colorComponentFrom(colorString, start: 0, length: 2)
            green = self.colorComponentFrom(colorString, start: 2, length: 2)
            blue  = self.colorComponentFrom(colorString, start: 4, length: 2)
            break;
        case 6: // #AARRGGBB
            alpha = self.colorComponentFrom(colorString, start: 0, length: 2)
            red   = self.colorComponentFrom(colorString, start: 2, length: 2)
            green = self.colorComponentFrom(colorString, start: 4, length: 2)
            blue  = self.colorComponentFrom(colorString, start: 6, length: 2)
            break;
        default:
            alpha = 1.0
            red   = 0
            green = 0
            blue  = 0
            break;
        }
        if (alphaParam != -1) {
            alpha = alphaParam
        }
        return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public class func colorWithRed(red_color:Int, green_color:Int, blue_color:Int, alpha_color:CGFloat) -> UIColor {
        let color: UIColor = UIColor(red: CGFloat(red_color)/255.0, green: CGFloat(green_color)/255.0, blue: CGFloat(blue_color)/255.0, alpha: alpha_color)
        return color
    }
    
    public func blendedColorWithFraction(fraction: CGFloat, ofColor color: UIColor) -> UIColor {
        var r1: CGFloat = 1.0, g1: CGFloat = 1.0, b1: CGFloat = 1.0, a1: CGFloat = 1.0
        var r2: CGFloat = 1.0, g2: CGFloat = 1.0, b2: CGFloat = 1.0, a2: CGFloat = 1.0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
                       green: g1 * (1 - fraction) + g2 * fraction,
                       blue: b1 * (1 - fraction) + b2 * fraction,
                       alpha: a1 * (1 - fraction) + a2 * fraction)
    }
}