//
//  Log.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import os

private let subsystem = "com.badi.RecipePuppyKit"

struct Log {
    
    static let networking = OSLog(subsystem: subsystem, category: "networking")
    
    static let decoding = OSLog(subsystem: subsystem, category: "decoding")
    
}
