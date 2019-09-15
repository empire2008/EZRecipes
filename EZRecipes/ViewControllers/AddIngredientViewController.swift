//
//  AddIngredientViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 15/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class AddIngredientViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataController: DataController!
    var recipe: CookingRecipe!
    var ingredientList: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        
    }
}

extension AddIngredientViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
        cell.selectionStyle = .none
        cell.name.text = ingredientList[indexPath.row].name
        cell.amount.text = String(ingredientList[indexPath.row].amount)
        cell.unit.text = ingredientList[indexPath.row].unit
        
        return cell
    }
    
}
