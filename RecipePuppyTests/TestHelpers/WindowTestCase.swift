//
//  WindowTestCase.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 04/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import XCTest


class WindowTestCase: XCTestCase {

    public var window: UIWindow!
    private static let sharedWindow = UIWindow(frame: UIScreen.main.bounds)


    override func setUp() {
        super.setUp()
        window = WindowTestCase.sharedWindow
    }


    override func tearDown() {
        window?.subviews.forEach { $0.removeFromSuperview() }
        window?.rootViewController = nil
        window = nil
        super.tearDown()
    }

}
