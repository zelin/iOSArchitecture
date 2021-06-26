//
//  AnimatedStar.swift
//  Animated Star Rating
//
//  Created by Muhammad Umar on 25/06/2018.
//  Copyright © 2018 Neberox Technologies. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable class WGView: UIView {
    /* Initial fillColor used to create star lobes */
    @IBInspectable var fillColor : UIColor       =  UIColor.white {
        didSet {
            self.backgroundColor = self.fillColor
        }
    }
    
    @IBInspectable var strokeWidth : CGFloat     = 0 {
        didSet {
            self.layer.borderWidth = self.strokeWidth
        }
    }
    
    @IBInspectable var strokeColor : UIColor     = UIColor.clear {
        didSet {
            self.layer.borderColor = self.strokeColor.cgColor
        }
    }

    @IBInspectable var leftRoundedCorner: Bool          = false {
        didSet {
            addMaskedCorners()
        }
    }
    
    @IBInspectable var rightRoundedCorner: Bool          = false {
        didSet {
            addMaskedCorners()
        }
    }
    @IBInspectable var bottomLeftRoundedCorner: Bool          = false {
        didSet {
            addMaskedCorners()
        }
    }
    @IBInspectable var bottomRightRoundedCorner: Bool          = false {
        didSet {
            addMaskedCorners()
        }
    }

    @IBInspectable var cornerRadius: CGFloat   = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            addMaskedCorners()
        }
    }
    
    @IBInspectable var shadow: CGFloat   = 0 {
        didSet {
            self.layer.shadowRadius = shadow
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            self.layer.shadowOpacity = 0.3
        }
    }
    
    func addMaskedCorners() {
        
        var mask = CACornerMask()
        if rightRoundedCorner {
            mask.insert(.layerMaxXMinYCorner)
        }
        
        if leftRoundedCorner {
            mask.insert(.layerMinXMinYCorner)
        }
        
        if bottomLeftRoundedCorner {
            mask.insert(.layerMinXMaxYCorner)
        }
                
        if bottomRightRoundedCorner {
            mask.insert(.layerMaxXMaxYCorner)
        }
        
        if !mask.isEmpty {
            self.layer.maskedCorners = mask
        }
    }
}
