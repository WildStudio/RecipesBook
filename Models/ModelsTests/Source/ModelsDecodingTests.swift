//
//  ModelsDecodingTests.swift
//  ModelsTests
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import XCTest
@testable import Models

class ModelsDecodingTests: XCTestCase {
    
    private enum Constant {
        static let fielName = "results"
        static let fileExtension = "json"
        static let results = "results"
    }
    
    func testLoadData_FromLocalJSONFileIsNotNilAndDataIsCorrect() {
        // Given, When
        guard let data = localJSONData(),
            let recipes = decodeModels(Constant.results, data) as [Recipe]?
            else {
                XCTFail("No data was loaded.")
                return
        }
        
        let expectedTitle = "Vegetable-Pasta Oven Omelet"
        let expectedThumbnail = "http://img.recipepuppy.com/560556.jpg"
        let expectedThumbnailURL = URL(string: expectedThumbnail)!
        let expectedIngredients = "tomato, onions, red pepper, garlic, olive oil, zucchini, cream cheese, vermicelli, eggs, parmesan cheese, milk, italian seasoning, salt, black pepper"
        let expectedHref = "http://find.myrecipes.com/recipes/recipefinder.dyn?action=displayRecipe&recipe_id=520763"
        let expectedHrefURL = URL(string: expectedHref)!
        
        // Then
        XCTAssertNotNil(recipes)
        XCTAssertEqual(recipes.first?.title, expectedTitle)
        XCTAssertEqual(recipes.first?.thumbnail, expectedThumbnail)
        XCTAssertEqual(recipes.first?.thumbnailURL, expectedThumbnailURL)
        XCTAssertEqual(recipes.first?.ingredients, expectedIngredients)
        XCTAssertEqual(recipes.first?.href, expectedHref)
        XCTAssertEqual(recipes.first?.hrefURL, expectedHrefURL)
    }
    
    
    private func localJSONData() -> Data? {
        guard let url = Bundle(
            for: ModelsDecodingTests.self)
            .url(
                forResource: Constant.fielName,
                withExtension: Constant.fileExtension
            ),
            let data = try? Data(contentsOf: url) else {
                return nil
        }
        
        return data
    }
    
    
    private func decodeModels<M: Decodable>(_ key: String,  _ data: Data) -> [M]? {
        do {
            guard let json = decodedData(from: data),
                let value = json[key]
                else { return nil }
            let data = try serialize(value: value)
            let models = try JSONDecoder().decode([M].self, from: data)
            return models
        } catch _ {
            return nil
        }
    }
    
    
    private func decodedData(from data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
    
    
    private func serialize(value: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: value, options: [])
    }
    
}

