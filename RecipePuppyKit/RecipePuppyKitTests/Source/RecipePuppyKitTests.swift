//
//  RecipePuppyKitTests.swift
//  RecipePuppyKitTests
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import XCTest
import Models
@testable import RecipePuppyKit

final class ServiceTypeTests: XCTestCase {
    
    private enum Constant {
        static let ingredients = "onions,garlic"
        static let timeout = 10.0
        static let resultsNumber = 10
    }
    
    var serverConfig: ServerConfigType!
    var service: ServiceType!
    
    
    override func setUp() {
        serverConfig = ServerConfig(apiBaseUrl: URL(string: "http://www.recipepuppy.com/")!)
        service = Service(serverConfig: serverConfig)
    }
    
    
    func testDownloadUsersData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download http://www.recipepuppy.com/api")
        
        // Create a background task to download the data
        service.fetchRecipes(ingredients: Constant.ingredients, page: nil) { response in
            // Make sure we downloaded some data.
            XCTAssertNotNil(response, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.x
            expectation.fulfill()
            
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: Constant.timeout)
    }
    
    
    func testDownloadConcreteRecipesData() {
        let expectation = XCTestExpectation(
            description: "searches with one or multiple ingredients"
        )
        var data: [Recipe]?
        service.fetchRecipes(ingredients: Constant.ingredients, page: nil) { response in
            switch response {
            case .success(let recipes):
                data = recipes
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeout)
        XCTAssertNotNil(data?.first)
    }
    
}
