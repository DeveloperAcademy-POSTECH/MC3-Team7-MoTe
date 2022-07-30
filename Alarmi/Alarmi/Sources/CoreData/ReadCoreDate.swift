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
func readCoreData() -> [CoreDataDate] {

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    let request: NSFetchRequest<CoreDataDate> = CoreDataDate.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "callDate", ascending: true)]
    
    var items = [CoreDataDate]()
    
    do {
        items = try context.fetch(request)
    } catch {
        print(error)
    }
    
    for item in items {
        print("start : ",terminator: "")
        print(item.end ,terminator: " ")
        print("end : ",terminator: "")
        print(item.end ,terminator: " ")
        print("callTimePeriod: ",terminator: "")
        print(item.callTimePeriod, terminator: " ")
        print("callDate : ",terminator: "")
        print(item.callDate ,terminator: " ")
        print("moteDate : ",terminator: "")
        print(item.moteDate, terminator: " ")
        print()
    }
    
    return items
}
