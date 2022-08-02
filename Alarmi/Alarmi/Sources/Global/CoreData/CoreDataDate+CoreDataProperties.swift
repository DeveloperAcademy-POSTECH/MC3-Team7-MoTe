//
//  CoreDataDate+CoreDataProperties.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//
//

import Foundation
import CoreData

extension CoreDataDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataDate> {
        return NSFetchRequest<CoreDataDate>(entityName: "CoreDataDate")
    }

    @NSManaged public var callTimePeriod: Int16
    @NSManaged public var callDate: [Date]?
    @NSManaged public var id: UUID?

}

extension CoreDataDate: Identifiable {

}
