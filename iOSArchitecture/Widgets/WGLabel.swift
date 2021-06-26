//
//  CupzButton.swift
//  Cupz
//
//  Created by Muhammad Umar on 23/11/2018.
//  Copyright © 2018 Neberox Technologies. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
class WGLabel: UILabel
{
    let topInset = CGFloat(0), bottomInset = CGFloat(0), leftInset = CGFloat(2.0), rightInset = CGFloat(2.0)
    
    override func drawText(in rect: CGRect) {        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
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

    @IBInspectable var leftRoundedCorner : Bool          = false {
        didSet {
            addMaskedCorners()
        }
    }
    
    @IBInspectable var rightRoundedCorner       : Bool          = false{
        didSet {
            addMaskedCorners()
        }
    }
    @IBInspectable var bottomLeftRoundedCorner  : Bool          = false{
        didSet {
            addMaskedCorners()
        }
    }
    @IBInspectable var bottomRightRoundedCorner : Bool          = false{
        didSet {
            addMaskedCorners()
        }
    }

    @IBInspectable var cornerRadius : CGFloat   = 0{
        didSet {
            self.layer.cornerRadius = cornerRadius
            addMaskedCorners()
        }
    }
    
    @IBInspectable var shadow : CGFloat   = 0 {
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
        
        if mask.isEmpty{
            //self.layer.maskedCorners = nil
        }else{
            self.layer.maskedCorners = mask
        }
    }
}

extension WGLabel {
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}
