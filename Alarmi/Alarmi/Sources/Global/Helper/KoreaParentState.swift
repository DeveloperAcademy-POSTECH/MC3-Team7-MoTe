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
    case canCallLight
    case canCallDark

    var mode: UIUserInterfaceStyle {
        switch self {
        case .sleeping:
            return .dark
        case .working:
            return .light
        case .canCallLight:
            return .light
        case .canCallDark:
            return .dark
        }
    }

    struct TodayDdipModel {
        var imageName: String
        var description: String

        static let sleeping = TodayDdipModel(imageName: "sleeping", description: "자고 있을 시간이에요.")
        static let working = TodayDdipModel(imageName: "working", description: "전화 가능 시간이 아니에요.")
        static let canCall = TodayDdipModel(imageName: "waiting", description: "전화 가능 시간이에요.")
    }

    var todayModel: TodayDdipModel {
        switch self {
        case .sleeping:
            return .sleeping
        case .working:
            return .working
        case .canCallLight:
            return .canCall
        case .canCallDark:
            return .canCall
        }
    }
}
