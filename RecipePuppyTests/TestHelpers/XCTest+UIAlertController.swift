//
//  XCTest+UIAlertController.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//


import XCTest


extension XCTest {

    public func XCTAssertAlert(line: UInt = #line) {
        XCTAssertNotNil(presentedAlertController, line: line)
    }


    public var presentedAlertController: UIAlertController? {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        return rootViewController?.presentedViewController as? UIAlertController
    }
    
}
