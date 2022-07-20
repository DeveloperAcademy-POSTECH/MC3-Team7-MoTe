//
//  RegisterViewModel.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/20.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

final class RegisterViewModel {
    var alarmData: Alarm?

    init() {
        alarmData = Alarm(callTimeStart: "",
                          callTimeEnd: "",
                          startDate: "",
                          callPeriod: 15,
                          isCall: true,
                          isReCall: true,
                          numAlertCall: 6)
    }
    
    deinit {
        print("RegisterViewModel deinit")
    }
}
