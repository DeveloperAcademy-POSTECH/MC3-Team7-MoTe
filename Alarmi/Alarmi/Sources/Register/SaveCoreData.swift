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

// 저장하기
func planCoreDataSave(callTimePeriod: Int, callDate: Date) -> Bool {
    // App Delegate 호출
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    
    // App Delegate 내부에 있는 viewContext 호출
//    let managedContext = appDelegate.persistentContainer.viewContext
    let context: NSManagedObjectContext = appDelegate.initialContainer.viewContext

    // managedContext 내부에 있는 entity 호출
    let entity = NSEntityDescription.entity(forEntityName: "CoreDataDate", in: context)!
    
    // entity 객체 생성
    let object = NSManagedObject(entity: entity, insertInto: context)
    
    // 값 설정
    object.setValue(callTimePeriod, forKey: "callTimePeriod")
    object.setValue(callDate, forKey: "callDate")
    object.setValue(UUID(), forKey: "id")
    
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

func callTimeCoreDataSave(start: Date, end: Date) -> Bool {
    // App Delegate 호출
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    
    // App Delegate 내부에 있는 viewContext 호출
//    let managedContext = appDelegate.persistentContainer.viewContext
    let context: NSManagedObjectContext = appDelegate.initialContainer.viewContext

    // managedContext 내부에 있는 entity 호출
    let entity = NSEntityDescription.entity(forEntityName: "CoreDataDate", in: context)!
    
    // entity 객체 생성
    let object = NSManagedObject(entity: entity, insertInto: context)
    
    // 값 설정
    object.setValue(start, forKey: "start")
    object.setValue(end, forKey: "end")
    object.setValue(UUID(), forKey: "id")
    
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

func saveCoreData(callTimePeriod: Int, callDate: Date) -> Bool {
    // App Delegate 호출
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    
    // App Delegate 내부에 있는 viewContext 호출
//    let managedContext = appDelegate.persistentContainer.viewContext
    let context: NSManagedObjectContext = appDelegate.initialContainer.viewContext

    // managedContext 내부에 있는 entity 호출
    let entity = NSEntityDescription.entity(forEntityName: "CoreDataDate", in: context)!
    
    // entity 객체 생성
    let object = NSManagedObject(entity: entity, insertInto: context)
    
    // 값 설정
    object.setValue(callTimePeriod, forKey: "callTimePeriod")
    object.setValue(callDate, forKey: "callDate")
    object.setValue(UUID(), forKey: "id")
    
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

//let appDelegate = UIApplication.shared.delegate as! AppDelegate
//let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataDate")
//let object = NSEntityDescription.insertNewObject(forEntityName: "CoreDataDate", into: context)
////
//var coreDataList = [CoreDataDate]()
////
//func fetch() -> [NSManagedObject] {
//    // 앱 델리게이트 객체 참조
////    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    // 관리 객체 컨텍스트 참조
////    let context = appDelegate.persistentContainer.viewContext
//    // 요청 객체 생성
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataDate")
//    // 데이터 가져오기
//    let result = try? context.fetch(fetchRequest)
//    return result!
//}
//
//var list: [NSManagedObject] = {
//    return fetch()
//    }()
