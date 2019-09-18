//
//  CreateIngredientViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 16/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class CreateIngredientViewController: UIViewController {

    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var unit: UITextField!
    
    var dataController: DataController!
    var ingredient: IngredientStructure = IngredientStructure()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: Any) {
        if ingredientName.text != "" && amount != nil && unit != nil{
            ingredient.name = ingredientName.text!
            ingredient.amount =  amount.text!
            ingredient.unit = unit.text!
            let vc = presentingViewController as! AddIngredientViewController
            vc.ingredientList.append(ingredient)
            dismiss(animated: true, completion: nil)
        }
        else {
            emptyFieldAlertPopup()
        }
        
    }
}
