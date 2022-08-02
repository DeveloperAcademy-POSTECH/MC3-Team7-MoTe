//
//  RegisterCallTimeViewModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/29.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class RegisterCallTimeViewModel: ObservableObject {

    // MARK: Store Property

    private let userDeafults = CallTimeUserDefaults(key: .callTime)

    var startTime: Date = Date()
    var endTime: Date = Date()

    init() {}

    func startTimePickerAction(_ date: Date) {
        self.startTime = date
    }

    func endTimePickerAction(_ date: Date) {
        self.endTime = date
    }

    func storeCallTime() {
        userDeafults.save(
            .init(
                start: startTime,
                end: endTime)
        )
    }

    // MARK: Business Logic

}
