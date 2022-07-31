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
    @Published var isAlarm: Bool = true // TODO: UserDefaults 연결
    @Published var isAlarmAgain: Bool = true // TODO: UserDefaults 연결
    @Published var isNotificationAuthorized: Bool = false
    
    private let userNotificationManager = UserNotificationManager()

    init() { }
    
    // MARK: Business Logic
    
    func goalPeriodStepperDidChanged(_ value: Int) {
        goalPeriod = value
    }
    
    func alarmSwitchToggled(_ isOn: Bool) {
        isAlarm = isOn
    }
    
    func alarmAgainSwitchToggled(_ isOn: Bool) {
        isAlarmAgain = isOn
    }
    
    func checkNotificationAuthorization() {
        userNotificationManager.getAuthorizationStatus { isAuthorized in
            self.isNotificationAuthorized = isAuthorized
        }
    }
    
    func changeEditableStateOfView(isEditable: Bool, views: UIView...) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = isEditable ? 1 : 0.4
            let isUserInteractionEnabled: Bool = isEditable
            
            for view in views {
                view.layer.opacity = opacity
                view.isUserInteractionEnabled = isUserInteractionEnabled
            }
        }, completion: nil)
    }
}
