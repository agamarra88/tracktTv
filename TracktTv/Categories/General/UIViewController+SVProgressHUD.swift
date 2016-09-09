//
//  UIViewControllerSVProgressHUDExtension.swift
//  SOSMujer
//
//  Created by agamarra on 4/13/16.
//  Copyright © 2016 tv.bennu. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
 
    func showActivityIndicator() {
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.show()
    }
    
    func hideActivityIndicator() {
        dispatch_async(dispatch_get_main_queue(), {
            SVProgressHUD.dismiss()
        })
    }
    
}
