//
//  KoreanTimeDateManager.swift
//  Alarmi
//
//  Created by Woody on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

final class Formatter {

    static let HHCurrentDateFormatter: DateFormatter = {
        let v = DateFormatter()
        v.timeZone = .autoupdatingCurrent
        v.dateFormat = "HH"
        return v
    }()

    static let ddCurrentDateFormatter: DateFormatter = {
        let v = DateFormatter()
        v.timeZone = .autoupdatingCurrent
        v.dateFormat = "HH"
        return v
    }()

    static let MMCurrentDateFormatter: DateFormatter = {
        let v = DateFormatter()
        v.timeZone = .autoupdatingCurrent
        v.dateFormat = "M월"
        return v
    }()

    static let HHMMCurrentDateFormatter: DateFormatter = {
        let v = DateFormatter()
        v.timeZone = .autoupdatingCurrent
        v.dateFormat = "HH:mm"
        return v
    }()
}
