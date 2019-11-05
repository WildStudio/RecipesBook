//
//  MockServiceProvider.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

@testable import RecipePuppyKit

class MockServiceProvider  {

    static func service() -> ServiceType {
        return Service(serverConfig: serverConfiguration)
    }

    
    private static let serverConfiguration = ServerConfig(
        apiBaseUrl: URL(string: "http://www.recipepuppy.com/")!
    )
    
}
