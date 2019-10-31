//
//  Recipe.swift
//  Models
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

public struct Recipe: Codable {
    public let title: String
    public let href: String
    public let ingredients: String
    public let thumbnail: String
    
    public var thumbnailURL: URL? {
        URL(string: thumbnail)
    }
    
    public var hrefURL: URL? {
        URL(string: href)
    }
}
