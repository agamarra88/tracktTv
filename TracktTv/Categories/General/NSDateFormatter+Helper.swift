//
//  NSDateFormatter+Singleton.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 16/01/15.
//  Copyright (c) 2015 Nuevo Mundo. All rights reserved.
//

import Foundation

public let kDateFormatter = "dd/MM/yyyy hh:mm a";
public let kJSONDateFormatter = "yyyy-MM-dd\'T\'HH:mm:ss";

extension NSDateFormatter {

    class var sharedFormatter: NSDateFormatter {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : NSDateFormatter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NSDateFormatter()
            Static.instance!.timeZone = NSTimeZone.localTimeZone()
            Static.instance!.dateFormat = kDateFormatter
        }
        return Static.instance!
    }
    
    // MARK: - Private
    private func dateFromStringAndSetBackFormat(dateString:String) -> NSDate? {
        let date = self.dateFromString(dateString)
        self.dateFormat = kDateFormatter
        return date;
    }
    
    private func stringFromDateAndSetBackFormat(date:NSDate) -> String {
        let dateString = self.stringFromDate(date)
        self.dateFormat = kDateFormatter
        return dateString
    }
    
    // MARK: - Public
    func stringFromDate(date:NSDate, withFormat format:String) -> String {
        self.dateFormat = format
        return self.stringFromDateAndSetBackFormat(date)
    }
    
    func dateFromString(dateString:String, withFormat format:String) -> NSDate? {
        self.dateFormat = format
        return self.dateFromStringAndSetBackFormat(dateString)
    }
}