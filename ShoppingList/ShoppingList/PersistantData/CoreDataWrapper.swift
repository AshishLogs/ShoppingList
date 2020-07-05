//
//  CoreDataWrapper.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/4/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataWrapper {
    
    var model : ShoppingModel?
    
    init() {}
    
    init(_ model: ShoppingModel?) {
        self.model = model
        if let category = model?.categories, let ranking = model?.rankings {
            DispatchQueue.main.async { [weak self] in
                self?.save(category,ranking: ranking)
            }
        }
    }
    
    func save(_ categories: [Category], ranking: [Ranking]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "ShoppingCDModel", in: managedContext) else { return }
        let device = NSManagedObject.init(entity: entity, insertInto: managedContext)
        let categoryData = NSKeyedArchiver.archivedData(withRootObject: categories)
        let rankingData  = NSKeyedArchiver.archivedData(withRootObject: ranking)
        device.setValue(categoryData, forKey: "categories")
        device.setValue(rankingData, forKey: "rankings")
        do {
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingCDModel")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try appDelegate.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
                try managedContext.save()
            } catch _ as NSError {

            }
        }
    }
    
    func loadData(handler: @escaping (_ result: (categoy:[Category], rank: [Ranking])) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingCDModel")
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count != 0 {
                if let object = results.first as? ShoppingCDModel {
                    if let data = object.categories as? Data, let rankData = object.rankings as? Data {
                        if let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Category], let unarchiveRank = NSKeyedUnarchiver.unarchiveObject(with: rankData) as? [Ranking] {
                            handler((unarchivedObject, unarchiveRank))
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}
