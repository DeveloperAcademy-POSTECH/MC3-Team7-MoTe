//
//  RegisterPlanViewModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/29.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class RegisterPlanViewModel: ObservableObject {

    // MARK: Store Property
    @Published var callTimePeriod: Int = 7
    private var goalTime: GoalTime = .init(startDate: Date(), period: 7)

    init() {}
    
    // MARK: Business Logic

    func settingDayStepper(_ value: Int) {
        callTimePeriod = value
    }

    func settingStartDatePicker(_ date: Date) {
        goalTime.startDate = date
    }

    func buttonDidTap() {
        GoalTimeUserDefaults(key: .goalTime).save(goalTime)
    }
}
