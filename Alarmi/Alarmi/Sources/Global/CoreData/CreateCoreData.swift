//
//  SaveCoreData.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//
import Foundation
import CoreData
import UIKit

func createCoreData() -> Bool {
    
    // App Delegate 호출
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }

    // App Delegate 내부에 있는 viewContext 호출
    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

    // managedContext 내부에 있는 entity 호출
    let entity = NSEntityDescription.entity(forEntityName: "CoreDataDate", in: context)!

    // entity 객체 생성
    let object = NSManagedObject(entity: entity, insertInto: context)
    
    // 값 설정
    object.setValue(UUID(), forKey: "id")
    object.setValue(7, forKey: "callTimePeriod")
    object.setValue([Date()], forKey: "callDate")
    
    do {
        // managedContext 내부의 변경사항 저장
        print("save")
        try context.save()
        return true
    } catch let error as NSError {
        // 에러 발생시
        print("Could not save. \(error), \(error.userInfo)")
        return false
    }
}
