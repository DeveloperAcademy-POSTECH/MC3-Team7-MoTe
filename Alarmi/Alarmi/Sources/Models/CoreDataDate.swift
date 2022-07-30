//
//  CoreDataDate.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(CoreDataGoalModel)
class CoreDataGoalModel: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var callDate: Date?
    @NSManaged var callTimePeriod: NSNumber!
    @NSManaged var moTeDate: [Date]
    @NSManaged var start: Date?
    @NSManaged var end: Date?
}
