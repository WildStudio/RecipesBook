//
//  UIAlert+Configuration.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import RecipePuppy

extension UIAlertController {

    public static func == (lhs: UIAlertController, rhs: AlertConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.body
    }

}
