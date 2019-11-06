//
//  MockConstant.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
@testable import Models

enum MockConstant {
    static let firstRecipe = Recipe(
        title: "Spaghetti alla carbonara",
        href: "http://carbonara.com",
        ingredients: "Guanciale (or pancetta), eggs, hard cheese (usually Pecorino Romano, Parmesan, or a mixture of the two), black pepper",
        thumbnail: "https://upload.wikimedia.org/wikipedia/commons/c/c1/Spaghetti_alla_Carbonara_%28cropped%29.jpg"
    )
    
    static let secondRecipe = Recipe(
        title: "Crispy Gnocchi with Basil Pesto",
        href: "http://gnocchi.com",
        ingredients: "fresh basil leaves packed, grated Parmesan-Reggiano cheese, virgin olive oil, cup pine nuts, garlic cloves minced, salt and freshly ground black pepper to taste, potato gnocchi, parmesan",
        thumbnail: ""
    )
}
