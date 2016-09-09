//
//  String+Validation.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 6/23/15.
//  Copyright (c) 2015 Nuevo Mundo. All rights reserved.
//

import Foundation

extension String {
   
    static func isEmail(email:String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTester = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTester.evaluateWithObject(email)
    }
    
    static func isAlphaNumeric(text:String) -> Bool {
        let set = NSCharacterSet.alphanumericCharacterSet()
        return text.rangeOfCharacterFromSet(set) == nil
    }
    
    static func isAlphaOnly(text:String) -> Bool {
        var set = NSCharacterSet(charactersInString: "aábcdeéfghiíjklmnoópqrstuúvwxyzAÁBCDEÉFGHIÍJKLMNOÓPQRSTUÚVWXYZ_")
        set = set.invertedSet
        return text.rangeOfCharacterFromSet(set) == nil
    }
    
    static func isNumericOnly(text:String) -> Bool {
        let set = NSCharacterSet.decimalDigitCharacterSet()
        return text.rangeOfCharacterFromSet(set) == nil
    }
    
}