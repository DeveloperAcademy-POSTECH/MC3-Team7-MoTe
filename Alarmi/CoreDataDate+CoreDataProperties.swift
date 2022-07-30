//
//  CoreDataDate+CoreDataProperties.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/30.
//  Copyright © 2022 MoTe. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataDate> {
        return NSFetchRequest<CoreDataDate>(entityName: "CoreDataDate")
    }

    @NSManaged public var callDate: Date?
    @NSManaged public var callTimePeriod: Int16
    @NSManaged public var end: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isAlarm: Bool
    @NSManaged public var isAlarmAgain: Bool
    @NSManaged public var start: Date?
    @NSManaged public var moteDate: [Date]?

}

extension CoreDataDate : Identifiable {

}
