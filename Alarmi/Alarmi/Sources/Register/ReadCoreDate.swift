//
//  ReadCoreDate.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/30.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//읽어오기
func readCoreData() throws -> [NSManagedObject]? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let managedContext = appDelegate.initialContainer.viewContext
    
    // Entity의 fetchRequest 생성
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataDate")
    
    // 정렬 또는 조건 설정
    //    let sort = NSSortDescriptor(key: "createDate", ascending: false)
    //    fetchRequest.sortDescriptors = [sort]
    //    fetchRequest.predicate = NSPredicate(format: "isFinished = %@", NSNumber(value: isFinished))
    print("managedContext : ")
    print(managedContext)
    do {
        // fetchRequest를 통해 managedContext로부터 결과 배열을 가져오기
        let resultCDArray = try managedContext.fetch(fetchRequest)
        return resultCDArray
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        throw error
    }
}
