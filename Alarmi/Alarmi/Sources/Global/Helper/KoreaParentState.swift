//
//  KoreaParentState.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

enum KoreaParentState {
    case sleeping
    case working
    case canCall

    var mode: UIUserInterfaceStyle {
        switch self {
        case .sleeping:
            return .dark
        case .working:
            return .light
        case .canCall:
            return .unspecified
        }
    }

    struct TodayDdipModel {
        var imageName: String
        var description: String

        static let sleeping = TodayDdipModel(imageName: "sleeping", description: "it’s not available time to call.")
        static let working = TodayDdipModel(imageName: "working", description: "it’s not available time to call.")
        static let canCall = TodayDdipModel(imageName: "waiting", description: "it’s time to call.")
    }

    var todayModel: TodayDdipModel {
        switch self {
        case .sleeping:
            return .sleeping
        case .working:
            return .working
        case .canCall:
            return .canCall
        }
    }
}
