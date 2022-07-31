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
    @Published var goalPeriod: Int = 7
    @Published var callStartTime: Date = Date()
    @Published var callEndTime: Date = Date()
    @Published var isAlarm: Bool = true
    @Published var isAlarmAgain: Bool = true
    @Published var isNotificationAuthorized: Bool = false
    
    private let userNotificationManager = UserNotificationManager()

    init() {
        
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
