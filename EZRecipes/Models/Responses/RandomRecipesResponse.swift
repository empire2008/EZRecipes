//
//  RandomRecipesResponse.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 11/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation

struct RandomRecipesResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    let readyInMinutes: Int
    let servings: Int
    let healthScore: Int
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let instructions: String
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstructions]
    let extendedIngredients: [IngredientDetail]
}

struct AnalyzedInstructions: Codable {
    let steps : [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
}

struct IngredientDetail: Codable {
    let id: Double
    let image: String
    let name: String
    let original: String
    let originalString: String
    let originalName: String
    let amount: Double
    let unit: String
}
