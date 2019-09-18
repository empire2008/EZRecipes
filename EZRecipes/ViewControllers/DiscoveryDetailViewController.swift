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
    
    var recipe: Recipe!
    var dataController: DataController!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        
        if !recipe.analyzedInstructions.isEmpty{
            if !recipe.analyzedInstructions[0].steps.isEmpty{
                stepStackView.isHidden = false
                for step in recipe.analyzedInstructions[0].steps{
                    print(step.step)
                    let stepLabel = UILabel()
                    stepLabel.text = "\(step.number). \(step.step)"
                    ingredientStackView.addArrangedSubview(stepLabel)
                    stepLabel.translatesAutoresizingMaskIntoConstraints = false
                    stepLabel.topAnchor.constraint(equalTo: ingredientStackView.topAnchor).isActive = true
                    stepLabel.bottomAnchor.constraint(equalTo: ingredientStackView.bottomAnchor).isActive = true
                    stepLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
                    stepLabel.leftAnchor.constraint(equalTo: ingredientStackView.leftAnchor).isActive = true
                    stepLabel.rightAnchor.constraint(equalTo: ingredientStackView.rightAnchor).isActive = true
                }
            }
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
                ingredient.amount = String(i.amount)
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.recipeId = cookingRecipe.id
                dataController.saveContext()
            }
        }
        
        if !recipe.analyzedInstructions.isEmpty{
            if !recipe.analyzedInstructions[0].steps.isEmpty{
                for index in 0..<recipe.analyzedInstructions[0].steps.count{
                    let step = CookingStep(context: dataController.viewContext)
                    step.recipeId = cookingRecipe.id
                    step.number = Int64(recipe.analyzedInstructions[0].steps[index].number)
                    step.stepDescription = recipe.analyzedInstructions[0].steps[index].step
                    dataController.saveContext()
                }
            }
        }

        dataController.saveContext { (success, error) in
            if success{
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
