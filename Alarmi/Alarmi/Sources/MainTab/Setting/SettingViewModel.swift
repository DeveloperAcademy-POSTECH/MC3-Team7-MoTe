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
    @Published var goalPeriod: Int
    @Published var callStartTime: Date
    @Published var callEndTime: Date
    @Published var isAlarm: Bool
    @Published var isAlarmAgain: Bool
    @Published var isNotificationAuthorized: Bool = false
    
    private let userNotificationManager = UserNotificationManager()
    private let goalTimeUserDefaults = GoalTimeUserDefaults(key: .goalTime)
    private let callTimeUserDefaults = CallTimeUserDefaults(key: .callTime)
    private let alarmUserDefaults = AlarmUserefaults(key: .alarm)

    init() {
        goalPeriod = goalTimeUserDefaults.data?.period ?? 7
        callStartTime = callTimeUserDefaults.data?.start ?? Date()
        callEndTime = callTimeUserDefaults.data?.end ?? Date()
        isAlarm = alarmUserDefaults.data?.isAlarm ?? true
        isAlarmAgain = alarmUserDefaults.data?.isAlarmAgain ?? true
    }
    
    // MARK: Business Logic
    
    func goalPeriodStepperDidChanged(_ value: Int) {
        goalPeriod = value
        // TODO: UserDefaults에 저장
    }
    
    func startTimePickerDidChanged(_ date: Date) {
        callStartTime = date
        // TODO: UserDefaults에 저장
    }
    
    func endTimePickerDidChanged(_ date: Date) {
        callEndTime = date
        // TODO: UserDefaults에 저장
    }
    
    func alarmSwitchToggled(_ isOn: Bool) {
        isAlarm = isOn
        // TODO: UserDefaults에 저장
    }
    
    func alarmAgainSwitchToggled(_ isOn: Bool) {
        isAlarmAgain = isOn
        // TODO: UserDefaults에 저장
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
