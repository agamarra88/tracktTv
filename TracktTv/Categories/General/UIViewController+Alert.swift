//
//  UIViewControllerAlertExtension.swift
//  SOSMujer
//
//  Created by agamarra on 12/16/15.
//  Copyright © 2015 Bennu.tv. All rights reserved.
//

import UIKit

//Alert Extension
extension UIViewController {

    func showErrorViewWithMessage(message:String) {
        self.showAlertViewWithTitle(NSLocalizedString("Error", comment: "Error"), withMessage: message)
    }
    
    func showAlertViewWithMessage(message:String) {
        self.showAlertViewWithTitle(NSLocalizedString("Alert", comment: "Alerta"), withMessage: message)
    }
    
    func showAlertViewWithTitle(title:String, withMessage message:String) {
        self.showAlertViewWithTitle(title, withMessage: message, withResponseBlock: nil)
    }
    
    func showAlertViewWithTitle(title:String, withMessage message:String, withResponseBlock responseBlock:(() -> Void)?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .Default) { (action:UIAlertAction) -> Void in
            if (responseBlock != nil) {
                responseBlock!()
            }
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(okAction)
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    func showOkCancelAlertViewWithTitle(title:String, withMessage message:String, withResponseBlock responseBlock:(isOk:Bool) -> Void) {
        let okTitle = NSLocalizedString("OK", comment: "OK")
        self.showOkCancelAlertViewWithTitle(title, withMessage: message, withOkTitle: okTitle, withResponseBlock: responseBlock)
    }
    
    func showOkCancelAlertViewWithTitle(title:String, withMessage message:String, withOkTitle okTitle:String, withResponseBlock responseBlock:(isOk:Bool) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: okTitle, style: .Default) { (action:UIAlertAction) -> Void in
            responseBlock(isOk: true)
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .Default) { (action:UIAlertAction) -> Void in
            responseBlock(isOk: false)
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        self.presentViewController(alertViewController, animated: true, completion:nil)
    }
    
}

