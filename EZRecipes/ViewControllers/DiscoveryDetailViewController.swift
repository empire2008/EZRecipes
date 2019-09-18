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
                    stepLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
                    stepLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
                    stepLabel.leftAnchor.constraint(equalTo: ingredientStackView.leftAnchor).isActive = true
                    stepLabel.rightAnchor.constraint(equalTo: ingredientStackView.rightAnchor).isActive = true
                }
            }
        }
    }
    
    func setHeader(){
        recipeName.text = recipe.title
        recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
    }
}
