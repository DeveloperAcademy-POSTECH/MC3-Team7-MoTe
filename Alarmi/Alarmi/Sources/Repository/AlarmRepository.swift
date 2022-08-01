//
//  AlarmRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol AlarmRepository {
    var alarm: CurrentValueSubject<Alarm, Never> { get }

    func update(alarm: Alarm)
}
final class AlarmRepositoryImpl: AlarmRepository {
    private let alarmUserDefaults = AlarmUserefaults(key: .alarm)

    lazy var alarm = CurrentValueSubject<Alarm, Never>(value)

    func update(alarm: Alarm) {
        alarmUserDefaults.removeAll()
        alarmUserDefaults.save(alarm)
        self.alarm.send(alarm)
    }
}

extension AlarmRepositoryImpl {
    var value: Alarm {
        alarmUserDefaults.data ?? .init(isAlarm: true, isAlarmAgain: true)
    }
}
