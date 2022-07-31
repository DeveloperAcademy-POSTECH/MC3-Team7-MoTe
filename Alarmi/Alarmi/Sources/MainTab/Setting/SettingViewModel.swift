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
    @Published var isAlarmSwitchOn: Bool = true // TODO: UserDefaults 연결
    @Published var isAlarmAgainSwitchOn: Bool = true // TODO: UserDefaults 연결

    init() {}
    
    // MARK: Business Logic
    
    func goalPeriodStepperDidChanged(_ value: Int) {
        goalPeriod = value
    }
    
    func alarmSwitchToggled(_ isOn: Bool) {
        isAlarmSwitchOn = isOn
    }
    
    func alarmAgainSwitchToggled(_ isOn: Bool) {
        isAlarmSwitchOn = isOn
    }
    
    func disableView(canBeEdited: Bool, view: UIView) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = canBeEdited ? 1 : 0.4
            let isUserInteractionEnabled: Bool = canBeEdited
            
            view.layer.opacity = opacity
            view.isUserInteractionEnabled = isUserInteractionEnabled
        }, completion: nil)
    }
}
