//
//  Collection+SafeTests.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 03/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import XCTest
@testable import RecipePuppy

class Collection_SafeTests: XCTestCase {
    
    func testArrayWhenIndexIsValidReturnsElement() {
        // Given
        let testArray = [1,2]
        
        // When
        let validIndex = testArray.indices.randomElement()!
        let element = testArray[safe: validIndex]
        
        // Then
        XCTAssertNotNil(element)
    }
    
    
    func testArrayWhenIndexEqualsArrayElementsCountReturnsNil() {
        // Given
        let testArray = [1,2]
        
        // When
        let invalidIndex = testArray.count
        let element = testArray[safe: invalidIndex]
        
        // Then
        XCTAssertNil(element)
    }
    
    
    func testArrayWhenIndexIsNegativeReturnsNil() {
        // Given
        let testArray = [1,2]
        
        // When
        let negativeIndex = -1
        let element = testArray[safe: negativeIndex]
        
        // Then
        XCTAssertNil(element)
    }
    
}
