//
//  UILabel+Rotation.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 03/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

extension UILabel {
    
    @IBInspectable var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
}
