//
//  NSDate+Helper.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 21/01/15.
//  Copyright (c) 2015 Nuevo Mundo. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringFormat(format:String) -> String {
        let formater = NSDateFormatter.sharedFormatter;
        return formater.stringFromDate(self, withFormat: format);
    }
    
}