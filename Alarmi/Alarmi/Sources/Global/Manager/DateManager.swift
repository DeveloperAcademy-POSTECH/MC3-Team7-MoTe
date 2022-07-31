//
//  KoreanTimeDateManager.swift
//  Alarmi
//
//  Created by Woody on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

final class DateManager {
    static let shared = DateManager()

    let dateFormatter = DateFormatter()

    private init() {
        dateFormatter.timeZone = .autoupdatingCurrent
    }
}
