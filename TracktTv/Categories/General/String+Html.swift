//
//  StringFormatExtension.swift
//  SOSMujer
//
//  Created by agamarra on 12/21/15.
//  Copyright © 2015 Bennu.tv. All rights reserved.
//

import Foundation
import UIKit

// String Format Extension
extension String {

    static func stringByRemoveHTMLTags(string:String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "<[^>]*>", options: NSRegularExpressionOptions.CaseInsensitive)
            return regex.stringByReplacingMatchesInString(string, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, string.characters.count), withTemplate: "")
            
        } catch  {
            return string
        }
    }
    
    static func stringByDecodeHTMLString(string: String) -> String {
        let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            return string
        }
    }
}
