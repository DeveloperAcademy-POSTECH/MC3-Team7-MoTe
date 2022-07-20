//
//  RegisterViewModel.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/20.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

final class RegisterViewModel {
    var alarmData: Alarm? = Alarm()
    
    deinit {
        print("RegisterViewModel deinit")
    }
}
