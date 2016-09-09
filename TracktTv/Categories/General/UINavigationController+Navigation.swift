//
//  UINavigationController+Navigation.swift
//  Glup
//
//  Created by Mariano Cornejo on 9/6/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
 
    func popToViewControllerOfClass(aClass: AnyClass, animated: Bool) -> Void {
        let viewControllers = self.viewControllers
        for viewController in viewControllers {
            if viewController.isKindOfClass(aClass) {
                self.popToViewController(viewController, animated: animated)
                return
            }
        }
    }
}