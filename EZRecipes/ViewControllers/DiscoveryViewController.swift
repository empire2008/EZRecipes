//
//  DiscoveryViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 12/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let itemPerRandom = 50
    var recipesData: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomRecipes()
    }
    
    func randomRecipes(){
        AppClient.requestRandomRecipes(itemAmount: itemPerRandom, complition: handleRandomRecipes(recipeResponse:error:))
    }
    
    func handleRandomRecipes(recipeResponse: RandomRecipesResponse?, error: Error?){
        if let recipeResponse = recipeResponse{
            recipesData = recipeResponse.recipes
        }
        else{
            print("ERROR: \(error?.localizedDescription ?? "")")
        }
    }
}

extension DiscoveryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveryCell", for: indexPath) as! DiscoveryCell
        
        return cell
    }
    
    
}
