//
//  CoreDataDate.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import CoreData


@objc(CoreDataDate)
class CoreDataDate: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var callDate: Date?
}
