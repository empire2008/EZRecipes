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
    var recipe: RecipeStructure = RecipeStructure()
    var ingredientList: [IngredientStructure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Recipe: \(recipe)")
        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(ingredientList)
        tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "nextStep", sender: self)
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        performSegue(withIdentifier: "createrView", sender: self)
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
        cell.amount.text = ingredientList[indexPath.row].amount
        cell.unit.text = ingredientList[indexPath.row].unit
        
        return cell
    }
    
}

extension AddIngredientViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createrView"{
            let vc = segue.destination as! CreateIngredientViewController
            vc.dataController = dataController
        }
        else if segue.identifier == "nextStep"{
            let vc = segue.destination as! AddStepViewController
            vc.dataController = dataController
            vc.recipe = recipe
            vc.ingredientList = ingredientList
        }
    }
}
