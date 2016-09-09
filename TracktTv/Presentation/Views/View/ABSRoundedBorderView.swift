//
//  SOSMRoundedView.swift
//  SOSMujer
//
//  Created by Arturo Gamarra on 12/21/15.
//  Copyright © 2015 Bennu.tv. All rights reserved.
//

import UIKit

@IBDesignable class ABSRoundedBorderView: UIView {

    // MARK: - Properties
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.clearColor() {
        didSet {
            self.layer.borderColor = self.borderColor.CGColor
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.CGColor
    }
}
