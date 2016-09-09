//
//  UIImageExtension.swift
//  SOSMujer
//
//  Created by Arturo Gamarra on 2/7/16.
//  Copyright © 2016 tv.bennu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func fromColor(color: UIColor) -> UIImage {
        return self.fromColor(color, ofSize: CGSizeMake(1, 1))
    }
    
    class func fromColor(color: UIColor, ofSize size:CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}