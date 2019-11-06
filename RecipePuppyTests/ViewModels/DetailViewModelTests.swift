//
//  DetailVIewModelTests.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

@testable import RecipePuppy
import XCTest

class DetailViewModelTests: XCTestCase {
    
    
    func testURL_ReturnsCorrectURL() {
        // Given
        let url = URL(string: "https://jobs.badi.com")!
        
        //When
        let viewModel = DetailViewModel(url)
        
        // Then
        XCTAssertEqual(url, viewModel.url)
    }
    
}
