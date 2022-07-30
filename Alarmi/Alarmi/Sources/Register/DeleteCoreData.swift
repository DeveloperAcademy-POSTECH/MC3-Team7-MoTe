//
//  DeleteCoreData.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/30.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//삭제
func deleteCoreData(id: UUID) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.initialContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    
    // 아이디를 삭제 기준으로 설정
    fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        let objectToDelete = result[0] as! NSManagedObject
        managedContext.delete(objectToDelete)
        try managedContext.save()
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}
