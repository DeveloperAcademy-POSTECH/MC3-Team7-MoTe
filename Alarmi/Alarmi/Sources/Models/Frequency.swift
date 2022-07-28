//
//  Frequency.swift
//  Alarmi
//
//  Created by Woody on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct Frequency: Hashable {
    var id = UUID()
    var type: CallType
    var date: MoTeDate
}
