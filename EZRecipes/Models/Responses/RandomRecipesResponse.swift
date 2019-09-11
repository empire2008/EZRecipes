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
}

struct AnalyzedInstructions: Codable {
    let steps : [CcokingStep]
}

struct CcokingStep: Codable {
    let number: Int
    let step: String
}
