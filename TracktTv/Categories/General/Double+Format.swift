//
//  Double+Helper.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 19/01/15.
//  Copyright (c) 2015 Nuevo Mundo. All rights reserved.
//

import Foundation

extension Double {
    
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
    
    func currencyIntegerFormat() -> String {
        let price = self.format(".0")
        return "US$ \(price)"
    }
    
    func currencyDecimalFormat() -> String {
        let price = self.format(".2")
        return "US$ \(price)"
    }

}