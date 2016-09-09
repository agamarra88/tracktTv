//
//  NSError+Helper.swift
//  Nuevo Mundo
//
//  Created by Arturo Gamarra on 5/2/16.
//  Copyright © 2016 Nuevo Mundo. All rights reserved.
//

import UIKit

extension NSError {

    convenience init(domain:String, code:Int, message:String) {
        let userInfo = [NSLocalizedDescriptionKey:message, NSLocalizedFailureReasonErrorKey:message, NSLocalizedRecoverySuggestionErrorKey:message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }

}
