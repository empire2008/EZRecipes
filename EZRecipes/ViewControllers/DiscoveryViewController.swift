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
    
    let itemPerRandom = 15
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
            collectionView.reloadData()
        }
        else{
            print("ERROR: \(error?.localizedDescription ?? "")")
        }
    }
    
    func loadImageFromURL(imageUrl: String) -> UIImage?{
        do{
            let data = try Data(contentsOf: URL(string: imageUrl)!)
            return UIImage(data: data)
        }
        catch{
            print("Load image error: \(error.localizedDescription)")
        }
        return UIImage(named: "")
    }
}

extension DiscoveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveryCell", for: indexPath) as! DiscoveryCell
        cell.foodName.text = recipesData[indexPath.item].title
        cell.imageProfile.image = loadImageFromURL(imageUrl: recipesData[indexPath.item].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / 3) - 4
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
