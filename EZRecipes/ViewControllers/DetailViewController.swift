//
//  DetailViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 14/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var chefNote: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var chefNoteStackView: UIStackView!
    @IBOutlet weak var ingredientStackView: UIStackView!
    @IBOutlet weak var stepStackView: UIStackView!
    @IBOutlet weak var topToolBar: UIView!
    
    // Discovery Data
    var recipe: Recipe!
    
    // Local Data
    var localRecipe: CookingRecipe!
    var localIngredients: [Ingredient] = []
    var localCookingSteps: [CookingStep] = []
    var localRecipeIndex: IndexPath!
    
    var dataController: DataController!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var saveButton: UIButton!
    var editButton: UIButton!
    var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if recipe != nil{
            setDiscoveryToolbar()
            loadDiscoveryData()
        }
        else{
            fetchIngredients()
            fetchCookingSteps()
            loadLocalRecipe()
        }
    }
    
    // MARK: In case this view was called from local data
    func loadLocalRecipe(){
        recipeName.text = localRecipe.nameOfRecipe
        
        if let imageData = localRecipe.imageOfRecipe{
            recipeImage.image = UIImage(data: imageData)
        }
        else if localRecipe.imageUrl != nil && localRecipe.imageUrl != ""{
            recipeImage.sd_setImage(with: URL(string: localRecipe.imageUrl!), completed: nil)
        }
        else{
            recipeImage.image = UIImage(named: "placeholder")
        }
        
        if !localIngredients.isEmpty{
            ingredientStackView.isHidden = false
            for ingredient in localIngredients{
                createIngredientPattern(name: ingredient.name!, amount: ingredient.amount ?? "-", unit: ingredient.unit ?? "N/A")
            }
        }
        
        if !localCookingSteps.isEmpty{
            stepStackView.isHidden = false
            for step in localCookingSteps{
                createStepPattern(number: "\(step.number)", step: step.stepDescription ?? "")
            }
        }
    }
    
    fileprivate func fetchIngredients() {
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipe == %@", localRecipe)
        fetchRequest.sortDescriptors = []
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            localIngredients = result
        }
    }
    
    fileprivate func fetchCookingSteps() {
        let fetchRequest: NSFetchRequest<CookingStep> = CookingStep.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipe == %@", localRecipe)
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor].reversed()
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            localCookingSteps = result
        }
    }
    
    // MARK: In case this view was called from Discovery data
    fileprivate func loadDiscoveryData() {
        // header
        recipeName.text = recipe.title
        recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
        
        // add ingredient
        if !recipe.extendedIngredients.isEmpty{
            ingredientStackView.isHidden = false
            for ingredient in recipe.extendedIngredients{
                createIngredientPattern(name: ingredient.name, amount: "\(ingredient.amount ?? 0)", unit: "\(ingredient.unit ?? "N/A")")
            }
        }
        
        // add cooking step
        if !recipe.analyzedInstructions.isEmpty{
            if !recipe.analyzedInstructions[0].steps.isEmpty{
                stepStackView.isHidden = false
                for step in recipe.analyzedInstructions[0].steps{
                    createStepPattern(number: "\(step.number)", step: step.step)
                }
            }
        }
        
        // chef note
        if recipe.instructions != ""{
            chefNoteStackView.isHidden = false
            let label = UILabel()
            label.numberOfLines = 0
            label.text = recipe.instructions
            chefNoteStackView.addArrangedSubview(label)
        }
    }
    
    func createStepPattern(number: String, step: String){
        let stepLabel = UILabel()
        stepLabel.text = "\(number). \(step)"
        stepLabel.numberOfLines = 0
        stepStackView.addArrangedSubview(stepLabel)
    }
    
    func createIngredientPattern(name: String, amount: String, unit: String){
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        ingredientStackView.addArrangedSubview(stackView)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = " - \(name)"
        
        let amountLabel = UILabel()
        amountLabel.numberOfLines = 0
        amountLabel.text = "\(amount)"
        
        let unitLabel = UILabel()
        unitLabel.numberOfLines = 0
        unitLabel.text = "\(unit)"
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(unitLabel)
    }
    
    // MARK: Set Toolbar for Local View
    func setLocalToolbar(){
        
    }
    
    // MARK: Set Toolbar for Discovery View
    func setDiscoveryToolbar(){
        saveButton = UIButton()
        saveButton.setImage(UIImage(named: "download-1"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        self.topToolBar.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.rightAnchor.constraint(equalTo: topToolBar.rightAnchor, constant: -12).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: topToolBar.centerYAnchor).isActive = true
    }
    
    // MARK: Save data to local
    @objc func saveAction(){
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
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
