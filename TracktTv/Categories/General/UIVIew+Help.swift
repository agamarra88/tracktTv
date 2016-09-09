//
//  UIVIew+Help.swift
//  Glup
//
//  Created by Arturo Gamarra on 9/3/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - Public
    func parentViewOfClass(aClass:AnyClass) -> UIView? {
        guard var parentView = self.superview else {
            return nil
        }
        while(!parentView.isKindOfClass(aClass)) {
            if (parentView.superview != nil) {
                parentView = parentView.superview!
            } else {
                return nil
            }
        }
        return parentView
    }

}
