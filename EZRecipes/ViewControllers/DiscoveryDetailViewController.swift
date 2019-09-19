//
//  DiscoveryDetailViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 14/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit
import SDWebImage

class DiscoveryDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var chefNote: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var chefNoteStackView: UIStackView!
    @IBOutlet weak var ingredientStackView: UIStackView!
    @IBOutlet weak var stepStackView: UIStackView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var recipe: Recipe!
    var dataController: DataController!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        print(recipe.extendedIngredients)
        if !recipe.extendedIngredients.isEmpty{
            ingredientStackView.isHidden = false
            for ingredient in recipe.extendedIngredients{
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.distribution = .fillEqually
                ingredientStackView.addArrangedSubview(stackView)
                
                let label = UILabel()
                label.numberOfLines = 0
                label.text = " - \(ingredient.name)"
                
                let amount = UILabel()
                amount.numberOfLines = 0
                amount.text = "\(ingredient.amount ?? 0)"
                
                let unit = UILabel()
                unit.numberOfLines = 0
                unit.text = "\(ingredient.unit ?? "N/A")"
                stackView.addArrangedSubview(label)
                stackView.addArrangedSubview(amount)
                stackView.addArrangedSubview(unit)
            }
        }
        
        if !recipe.analyzedInstructions.isEmpty{
            if !recipe.analyzedInstructions[0].steps.isEmpty{
                stepStackView.isHidden = false
                for step in recipe.analyzedInstructions[0].steps{
                    print(step.step)
                    let stepLabel = UILabel()
                    stepLabel.text = "\(step.number). \(step.step)"
                    stepLabel.numberOfLines = 0
                    stepStackView.addArrangedSubview(stepLabel)
                }
            }
        }
        
        if recipe.instructions != ""{
            chefNoteStackView.isHidden = false
            let label = UILabel()
            label.numberOfLines = 0
            label.text = recipe.instructions
            chefNoteStackView.addArrangedSubview(label)
        }
    }
    
    @IBAction func saveToLocal(_ sender: Any) {
        dataController = appDelegate.dataController
        let cookingRecipe = CookingRecipe(context: dataController.viewContext)
        cookingRecipe.id = Date().timeStamp()
        cookingRecipe.imageUrl = recipe.image
        cookingRecipe.nameOfRecipe = recipe.title
        
        if !recipe.extendedIngredients.isEmpty{
            for i in recipe.extendedIngredients{
                let ingredient = Ingredient(context: dataController.viewContext)
//                ingredient.amount = String(i.amount)
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.recipeId = cookingRecipe.id
                ingredient.recipe = cookingRecipe
            }
        }
        
        if !recipe.analyzedInstructions.isEmpty{
            if !recipe.analyzedInstructions[0].steps.isEmpty{
                for index in 0..<recipe.analyzedInstructions[0].steps.count{
                    let step = CookingStep(context: dataController.viewContext)
                    step.recipeId = cookingRecipe.id
                    step.number = Int64(recipe.analyzedInstructions[0].steps[index].number)
                    step.stepDescription = recipe.analyzedInstructions[0].steps[index].step
                    step.recipe = cookingRecipe
                }
            }
        }

        dataController.saveContext { (success, error) in
            if success{
                self.saveButton.isEnabled = false
                self.popupAlert(title: "Saved", message: "This recipe already saved to My Recipe")
            }
            else{
                self.popupAlert(title: "Save Failed!", message: "Please try again!")
            }
        }
    }
    func setHeader(){
        recipeName.text = recipe.title
        recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
    }
}
