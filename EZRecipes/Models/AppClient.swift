//
//  AppClient.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 11/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation

class AppClient{
    
    static let baseUrl = "https://api.spoonacular.com/recipes/"
    struct Auth {
//        static let apiKey = "19e856f28a174650951620c9d9a47a57"
        static let apiKey = "b9135d68f0844127961c2fa705debfac"
        
    }
    enum EndPoint {
        case randomRecipes(Int)
        case searchRecipe(String,Int)

        var stringValue: String{
            switch self {
            case .randomRecipes(let itemAmount): return AppClient.baseUrl + "random?apiKey=\(Auth.apiKey)&number=\(itemAmount)"
            case .searchRecipe(let textSearch, let itemAmount): return AppClient.baseUrl + "search?apiKey=\(Auth.apiKey)&query=\(textSearch)&number=\(itemAmount)"
            }
        }
        
        var url: URL{
            return URL(string: stringValue)!
        }
    }
    
    class func requestRandomRecipes(itemAmount: Int, complition: @escaping (RandomRecipesResponse?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: EndPoint.randomRecipes(itemAmount).url) { data, response, error in
            print(EndPoint.randomRecipes(itemAmount).url)
            guard let data = data else{
                complition(nil, error)
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(RandomRecipesResponse.self, from: data)
                complition(responseObject, nil)
            }
            catch{
                complition(nil, error)
            }
        }
        task.resume()
    }
    
    class func requestSearchRecipeFromAPI(textSearch:String, itemAmount:Int, completion: @escaping (SearchRecipeResponse?, Error?) -> Void){
        print(EndPoint.searchRecipe(textSearch, itemAmount).url)
        let task = URLSession.shared.dataTask(with: EndPoint.searchRecipe(textSearch, 1).url) { data, response, error in
            print(EndPoint.searchRecipe(textSearch, itemAmount).url)
            guard let data = data else{
                completion(nil, error)
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(SearchRecipeResponse.self, from: data)
                completion(responseObject, nil)
            }
            catch{
                completion(nil, error)
            }
        }
        task.resume()
    }
}
