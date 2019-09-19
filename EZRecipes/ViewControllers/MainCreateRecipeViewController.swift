//
//  MainCreateRecipeViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 14/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class MainCreateRecipeViewController: UIViewController {

    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var recipePhoto: UIImageView!
    
    var dataController: DataController!
    var recipe = RecipeStructure()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = sourceType
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.imagePicker(sourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePicker(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        if recipeName.text != ""{
            recipe.id = Int(Date().timeStamp())
            recipe.nameOfRecipe = recipeName.text!
            performSegue(withIdentifier: "nextStep", sender: recipe)
        }
        else{
            emptyFieldAlertPopup()
        }
    }
}

extension MainCreateRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        recipePhoto.image = image
        recipe.imageOfRecipe = image?.pngData()
        
        dismiss(animated: true, completion: nil)
    }
}

extension MainCreateRecipeViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextStep"{
            let vc = segue.destination as! AddIngredientViewController
            vc.dataController = dataController
            vc.recipe = recipe
        }
    }
}
