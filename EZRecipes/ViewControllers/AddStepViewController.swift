//
//  AddStepViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 16/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class AddStepViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataController: DataController!
    var recipe: RecipeStructure!
    var ingredientList: [IngredientStructure]!
    var steps: [StepStructure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func createStep(_ sender: Any) {
        performSegue(withIdentifier: "createrView", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        if steps.count > 0{
            performSegue(withIdentifier: "nextStep", sender: self)
        }
        else{
            emptyFieldAlertPopup()
        }
    }
}

extension AddStepViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell") as! StepCell
        cell.selectionStyle = .none
        cell.stepDescription.text = "\(indexPath.row + 1). \(steps[indexPath.row].stepDescription)"
        if steps[indexPath.row].image != nil{
            cell.stepPhoto.isHidden = false
            cell.stepPhoto.image = UIImage(data: steps[indexPath.row].image!)
        }
        return cell
    }
    
    
}

extension AddStepViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextStep"{
            let vc = segue.destination as! ChefNoteViewController
            vc.dataController = dataController
            vc.recipe = recipe
            vc.ingredients = ingredientList
            vc.steps = steps
        }
    }
}
