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
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeName.text = recipe.title
        recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
        if recipe.instructions != ""{
            chefNote.text = recipe.instructions
        }
        ingredient.text = "\(recipe.extendedIngredients)"
    }
}
