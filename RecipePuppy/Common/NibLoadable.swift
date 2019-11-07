//
//  NibLoadable.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit


/// Protocol to help with loading a view from a Nib.
/// NOTE on implementing: Views that implement this must be declared final.
/// The default implementation is that the nibName matches the class name,
/// only situations other than this need to be explicitly declared.
public protocol NibLoadable {
    
    /// Nib name
    static var nibName: String { get }
    
    /// Load the nib
    static func nib() -> UINib
    
    /// Load view from associated nib
    /// - returns: The inflated view
    static func loadFromNib() -> Self
    
}


public extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: self.nibName, bundle: Bundle(for: self))
    }
    
    
    static func loadFromNib() -> Self {
        return nib().instantiate(withOwner: self, options: nil).first as! Self
    }
    
}
