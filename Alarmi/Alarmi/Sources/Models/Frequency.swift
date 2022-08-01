//
//  Frequency.swift
//  Alarmi
//
//  Created by Woody on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct Frequency: Hashable {
    var type: CallType
    var date: Date

    init(type: CallType,
         date: Date) {
        self.type = type
        self.date = date
    }

    static func == (lhs: Frequency, rhs: Frequency) -> Bool {
        (lhs.date == rhs.date) &&
        (lhs.type == rhs.type)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

enum CallType {
    case none
    case did
    case future
}
