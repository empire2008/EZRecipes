//
//  DataController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 13/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation
import CoreData

class DataController{
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "EZRecipes")
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }

    func load(complition: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else{
                fatalError("Load PersistentsStores failed: \(error!.localizedDescription)")
            }
            complition?()
        }
    }
}

extension DataController{
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }
            catch{
                print("Save error")
            }
        }
    }
}
