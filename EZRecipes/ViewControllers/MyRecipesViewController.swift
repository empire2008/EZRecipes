//
//  MyRecipesViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 13/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit
import CoreData
class MyRecipesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<CookingRecipe>!
    var dataController: DataController!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = appDelegate.dataController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    fileprivate func setupFetchedResultsController() {
        let fetchedRequest: NSFetchRequest<CookingRecipe> = CookingRecipe.fetchRequest()
        fetchedRequest.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        }
        catch{
            print("Fetched Error: \(error.localizedDescription)")
        }
    }
    @IBAction func addRecipeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateRecipe") as! MainCreateRecipeViewController
        controller.dataController = dataController
        self.present(controller, animated: true, completion: nil)

    }
}

extension MyRecipesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aRecipe = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRecipeCell") as! MyRecipeCell

        cell.selectionStyle = .none
        if aRecipe.imageOfRecipe != nil{
            cell.recipePhoto.image = UIImage(data: aRecipe.imageOfRecipe!)
        }
        else if aRecipe.imageUrl != "" && aRecipe.imageUrl != nil{
            cell.loadingActivity.startAnimating()
            cell.recipePhoto.sd_setImage(with: URL(string: aRecipe.imageUrl!)) { (image, erro, cache, url) in
                cell.loadingActivity.stopAnimating()
            }
        }
        else{
            cell.recipePhoto.image = UIImage(named: "placeholder")
        }
        cell.name.text = aRecipe.nameOfRecipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyRecipesViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update: tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move: tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default: break
        }
    }
}
