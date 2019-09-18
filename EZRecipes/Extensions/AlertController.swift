//
//  AlertController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 17/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func emptyFieldAlertPopup(){
        let alert = UIAlertController(title: "Warning", message: "Input fields cannot be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
