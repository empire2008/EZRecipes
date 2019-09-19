//
//  RandomRecipesResponse.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 11/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation

struct RandomRecipesResponse: Codable {
    var recipes: [Recipe]
}

struct Recipe: Codable {
    var id: Int = -1
    var title: String = ""
    var image: String = ""
    var imageType: String = ""
//    let readyInMinutes: Int
//    let servings: Int
//    let healthScore: Int
//    let vegetarian: Bool
//    let vegan: Bool
//    let glutenFree: Bool
//    let dairyFree: Bool
    var instructions: String = ""
//    let dishTypes: [String]
    var analyzedInstructions: [AnalyzedInstructions] = []
    var extendedIngredients: [IngredientDetail] = []
}

struct AnalyzedInstructions: Codable {
    var steps : [Step] = []
}

struct Step: Codable {
    var number: Int = -1
    var step: String = ""
}

struct IngredientDetail: Codable {
    let id: Double
//    let image: String
    let name: String
//    let original: String = ""
//    let originalString: String = ""
//    let originalName: String = ""
    let amount: Double?
    let unit: String?
}
