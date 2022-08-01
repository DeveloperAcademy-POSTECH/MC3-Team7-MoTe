//
//  SettingViewModel.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class SettingViewModel: ObservableObject {

    // MARK: Store Property
    @Published var goalPeriod: Int = 0
    @Published var callStartTime: Date = Date()
    @Published var callEndTime: Date = Date()
    @Published var isAlarm: Bool = true
    @Published var isAlarmAgain: Bool = true
    @Published var isNotificationAuthorized: Bool = false
    
    private let userNotificationManager = UserNotificationManager.shared

    private var model: SettingModel!
    private var cancellable = Set<AnyCancellable>()

    init(_ model: SettingModel) {
        self.model = model

        model.goalTime
            .sink { [weak self] in
                self?.goalPeriod = $0.period
            }.store(in: &cancellable)

        model.callTime
            .sink { [weak self] in
                self?.callStartTime = $0.start
                self?.callEndTime = $0.end
            }.store(in: &cancellable)

        model.alarm
            .sink { [weak self] in
                self?.isAlarm = $0.isAlarm
                self?.isAlarmAgain = $0.isAlarmAgain
            }.store(in: &cancellable)
    }

    // MARK: Business Logic
    
    func goalPeriodStepperDidChanged(_ value: Int) {
        goalPeriod = value
        let startDate = model.goalTime.value.startDate
        let newGoal = GoalTime(startDate: startDate, period: value)
        model.updateGoalTime(newGoal)
    }
    
    func startTimePickerDidChanged(_ date: Date) {
        callStartTime = date
        let endTime = model.callTime.value.end
        let newCallTime = CallTime(start: date, end: endTime)
        model.updateCallTimer(newCallTime)
    }
    
    func endTimePickerDidChanged(_ date: Date) {
        callEndTime = date
        let startTime = model.callTime.value.start
        let newCallTime = CallTime(start: startTime, end: date)
        model.updateCallTimer(newCallTime)
    }
    
    func alarmSwitchToggled(_ isOn: Bool) {
        isAlarm = isOn
        let isAlarmAgain = model.alarm.value.isAlarmAgain
        let alarm = Alarm(isAlarm: isOn, isAlarmAgain: isAlarmAgain)
        model.updateAlarm(alarm)
    }
    
    func alarmAgainSwitchToggled(_ isOn: Bool) {
        isAlarmAgain = isOn
        let isAlarm = model.alarm.value.isAlarm
        let alarm = Alarm(isAlarm: isAlarm, isAlarmAgain: isOn)
        model.updateAlarm(alarm)
    }
    
    func checkNotificationAuthorization() {
        userNotificationManager.getAuthorizationStatus { isAuthorized in
            self.isNotificationAuthorized = isAuthorized
        }
    }
    
    func changeEditableStateOfViewWithAnimation(isEditable: Bool, views: UIView...) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = isEditable ? 1 : 0.4
            let isUserInteractionEnabled: Bool = isEditable
            
            for view in views {
                view.layer.opacity = opacity
                view.isUserInteractionEnabled = isUserInteractionEnabled
            }
        }, completion: nil)
    }
    
    func changeEditableStateOfViewWithoutAnimation(isEditable: Bool, views: UIView...) {
        let opacity: Float = isEditable ? 1 : 0.4
        let isUserInteractionEnabled: Bool = isEditable
        
        for view in views {
            view.layer.opacity = opacity
            view.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    
    func changeTransparencyOfView(isTransparent: Bool, view: UIView) {
        let opacity: Float = isTransparent ? 0 : 1
        view.layer.opacity = opacity
    }
}
