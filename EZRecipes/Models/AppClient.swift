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
        static let apiKey = "19e856f28a174650951620c9d9a47a57"
    }
    enum EndPoint {
        case randomRecipes(Int)

        var stringValue: String{
            switch self {
            case .randomRecipes(let itemAmount): return AppClient.baseUrl + "random?apiKey=\(Auth.apiKey)&number=\(itemAmount)"
            }
        }
        
        var url: URL{
            return URL(string: stringValue)!
        }
    }
    
    class func requestRandomRecipes(itemAmount: Int, complition: @escaping (RandomRecipesResponse?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: EndPoint.randomRecipes(itemAmount).url) { data, response, error in
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
}
