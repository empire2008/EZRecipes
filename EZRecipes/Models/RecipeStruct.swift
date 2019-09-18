//
//  RecipeStruct.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 17/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation

struct RecipeStructure {
    var id: Int = -1
    var nameOfRecipe: String!
    var imageOfRecipe: Data?
    var imageUrl = ""
    var instruction = ""
    var ingredients: [IngredientStructure] = []
    var steps: [StepStructure] = []
}

struct IngredientStructure {
    var name: String!
    var amount = ""
    var unit = ""
}

struct StepStructure {
    var number: Int = -1
    var stepDescription = ""
    var image: Data?
    var imageUrl = ""
}
