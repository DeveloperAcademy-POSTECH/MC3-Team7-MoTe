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

func deleteCoreData(id: UUID) -> Bool {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.persistentContainer.viewContext
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

// 코어 데이터 전부 삭제
func resetAllRecords(in entity: String) // entity = Your_Entity_Name
{
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
        try context.execute(deleteRequest)
        try context.save()
    } catch {
        print("There was an error")
    }
}
