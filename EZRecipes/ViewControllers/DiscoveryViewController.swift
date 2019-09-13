//
//  DiscoveryViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 12/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit
import SDWebImage

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
            DispatchQueue.main.async {
                self.recipesData = recipeResponse.recipes
                self.collectionView.reloadData()
            }
        }
        else{
            print("ERROR: \(error?.localizedDescription ?? "")")
        }
    }
    
    func loadImageFromURL(imageUrl: String) -> UIImage?{
        DispatchQueue.global(qos: .background).async {
            do{
                let data = try Data(contentsOf: URL(string: imageUrl)!)
                DispatchQueue.main.async {
                    return UIImage(data: data)
                }
            }
            catch{
                print("Load image error: \(error.localizedDescription)")
            }
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
//        cell.imageProfile.image = self.loadImageFromURL(imageUrl: self.recipesData[indexPath.item].image)
        if recipesData[indexPath.item].image != ""{
            let url = URL(string: recipesData[indexPath.item].image)
            cell.imageProfile!.sd_setImage(with: url, completed: nil)
        }
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
        return 4
    }
}
