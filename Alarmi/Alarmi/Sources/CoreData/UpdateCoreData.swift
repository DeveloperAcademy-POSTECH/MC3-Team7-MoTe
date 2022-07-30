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
func updateCoreData(day: Date, keyName: String) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        let object = result.last as! NSManagedObject
        
        object.setValue(day, forKey: keyName)
        
        try managedContext.save()
        
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}

func updateCoreData(period: Int16, keyName: String) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        let object = result.last as! NSManagedObject
        
        object.setValue(period, forKey: keyName)
        
        try managedContext.save()
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}

func updateCoreData(isCall: Bool, keyName: String) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        let object = result.last as! NSManagedObject
        
        object.setValue(isCall, forKey: keyName)
        
        try managedContext.save()
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}

func updateToday() -> Bool {
    // Update 오늘 되도록
    // 중복 배열 X
    let day = Date()
    let keyName = "moteDate"
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CoreDataDate")
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        guard let object = result.last as? CoreDataDate else { return false }

        if object.moteDate == nil {
            object.setValue([day], forKey: keyName)
        } else {
            guard var curDate = object.moteDate else { return false }
            
            guard let lastDay = curDate.last else {return false}
            let lastDayComponent = Calendar.current.dateComponents([.year, .month, .day], from: lastDay)
            let todayComponent = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            if lastDayComponent == todayComponent {
                print("Fail!")
                return false
            } else {
                print("Success!")
                curDate.append(day)
                object.setValue(curDate, forKey: keyName)
            }
        }
        try managedContext.save()
        return true
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
        return false
    }
}
