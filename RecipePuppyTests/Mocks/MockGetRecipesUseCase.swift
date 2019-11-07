//
//  MockGetRecipesUseCase.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Models
@testable import RecipePuppy


final class MockGetRecipesUseCase: GetRecipesUsesCaseType {
    
    public var result: Result<[Recipe], Error> = .failure(MockServiceError.noMockResponse)
    public var isGetRecipesCalled = false
    
    
    func execute(
        _ ingredients: String,
        page: Int?,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        isGetRecipesCalled = true
        completion(result)
    }
    
}
