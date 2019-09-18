//
//  ChefNoteViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 17/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class ChefNoteViewController: UIViewController {

    @IBOutlet weak var note: UITextView!
    
    var dataController: DataController!
    var recipe: RecipeStructure!
    var ingredients: [IngredientStructure]!
    var steps: [StepStructure]!
    var recipeDataModel: CookingRecipe!
    var ingredientDataModel: Ingredient!
    var stepDataModel: CookingStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        recipeDataModel = CookingRecipe(context: dataController.viewContext)
        ingredientDataModel = Ingredient(context: dataController.viewContext)
        stepDataModel = CookingStep(context: dataController.viewContext)
    }
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: Any) {
        recipe.instruction = note.text
        
        saveRecipeDataModel()
        saveIngredientDataModel()
        saveStepDataModel()
        
        dataController.saveContext()
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func saveRecipeDataModel(){
        recipeDataModel.id = Date().timeStamp()
        recipeDataModel.nameOfRecipe = recipe.nameOfRecipe
        recipeDataModel.imageOfRecipe = recipe.imageOfRecipe
        recipeDataModel.instruction = recipe.instruction
    }
    
    func saveIngredientDataModel(){
        for ingredient in ingredients{
            ingredientDataModel.amount = ingredient.amount
            ingredientDataModel.unit = ingredient.unit
            ingredientDataModel.name = ingredient.name
            ingredientDataModel.recipeId = recipeDataModel.id
        }
    }
    
    func saveStepDataModel(){
        for index in 0..<steps.count{
            stepDataModel.recipeId = recipeDataModel.id
            stepDataModel.stepDescription = steps[index].stepDescription
            stepDataModel.image = steps[index].image
            stepDataModel.number = Int64(index + 1)
        }
    }
}
