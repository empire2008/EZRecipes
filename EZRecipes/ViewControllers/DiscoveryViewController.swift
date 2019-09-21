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
    @IBOutlet weak var noRecipeDataView: UIView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    
    let itemPerRandom = 51
    var recipesData: [Recipe] = []
    var reconnectCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()
        randomRecipes()
    }
    
    func randomRecipes(){
        loadingActivityView.startAnimating()
        AppClient.requestRandomRecipes(itemAmount: itemPerRandom, complition: handleRandomRecipes(recipeResponse:error:))
    }
    
    func getSearchRecipes(searchText: String){
        loadingActivityView.startAnimating()
        AppClient.requestSearchRecipeFromAPI(textSearch: searchText, itemAmount: 21, completion: handleSearchRecipe(searchResponse:error:))
    }
    
    func handleSearchRecipe(searchResponse: SearchRecipeResponse?, error:Error?){
        if let searchResponse = searchResponse{
            DispatchQueue.main.async {
                self.recipesData = searchResponse.results
                self.loadingActivityView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
        else{
            print("Error: \(error)")
        }
    }
    
    func handleRandomRecipes(recipeResponse: RandomRecipesResponse?, error: Error?){
        if let recipeResponse = recipeResponse{
            DispatchQueue.main.async {
                self.recipesData = recipeResponse.recipes
                self.loadingActivityView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
        else{
            print("ERROR: \(error)")
            reconnectCount += 1
            if reconnectCount <= 3{
                DispatchQueue.main.async {
                    self.randomRecipes()
                }
            }
            else{
                reconnectCount = 0
                self.loadingActivityView.stopAnimating()
                self.popupAlert(title: "Connection Failed", message: "Please try again later")
            }
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        randomRecipes()
    }
    
}

extension DiscoveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveryCell", for: indexPath) as! DiscoveryCell
        cell.foodName.text = recipesData[indexPath.item].title
        cell.loadingActivity.startAnimating()

        if recipesData[indexPath.item].image != "" && recipesData[indexPath.item].image != nil{
            let url = URL(string: recipesData[indexPath.item].image!)
            cell.imageProfile!.sd_setImage(with: url) { (image, error, sdCatch, url) in
                cell.loadingActivity.stopAnimating()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.recipe = recipesData[indexPath.row]
        
        present(vc, animated: true, completion: nil)
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

extension DiscoveryViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getSearchRecipes(searchText: searchBar.text!)
    }
    
}
