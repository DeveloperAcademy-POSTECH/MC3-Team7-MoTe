//
//  UpdateCoreData.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/30.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//업데이트
func updateCoreData(id: UUID, name: String, email: String) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.initialContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        let object = result[0] as! NSManagedObject
        
//        object.setValue(name, forKey: "name")
//        object.setValue(email, forKey: "email")
        
        try managedContext.save()
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}
