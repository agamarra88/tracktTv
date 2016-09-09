//
//  NSNumberFormatter+Help.swift
//  Glup
//
//  Created by Arturo Gamarra on 8/28/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import Foundation

extension NSNumberFormatter {

    // MARK: - Public
    class var sharedFormatter: NSNumberFormatter {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : NSNumberFormatter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NSNumberFormatter()
        }
        return Static.instance!
    }
    
    func numberFromCurrency(currency:String) -> NSNumber? {
        self.formatterBehavior = .Behavior10_4
        self.numberStyle = .DecimalStyle
        self.positiveFormat = "#0.00"
        self.usesGroupingSeparator = false
        return self.numberFromString(currency)
    }
    
    func currencyFromNumber(number:NSNumber) -> String? {
        self.formatterBehavior = .Behavior10_4
        self.numberStyle = .DecimalStyle
        self.positiveFormat = "#0.00"
        self.usesGroupingSeparator = false
        return self.stringFromNumber(number)
    }
    
    func currencyCompleteFromNumber(number:NSNumber, withSymbol symbol:String) -> String {
        if let formattedNumber = self.currencyFromNumber(number) {
            return "\(symbol) \(formattedNumber)"
        }
        return ""
    }
    
}
