//
//  NSDate+JavascriptTimestamp.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 5/8/16.
//  Copyright © 2016 Nuevo Mundo. All rights reserved.
//

import UIKit

extension NSDate {

    // MARK: - Public
    convenience init(javascriptTimestamp:Double) {
        self.init(timeIntervalSince1970:javascriptTimestamp/1000)
    }
    
    var javascriptTimestamp:NSNumber {
        return NSDate.javascriptTimestampFromDate(self)
    }
    
    class func javascriptTimestampNow() -> NSNumber {
        return NSNumber(double:round(NSDate().timeIntervalSince1970*1000))
    }
    
    class func javascriptTimestampFromDate(date:NSDate) -> NSNumber {
        return NSNumber(double: round(date.timeIntervalSince1970*1000))
    }
}