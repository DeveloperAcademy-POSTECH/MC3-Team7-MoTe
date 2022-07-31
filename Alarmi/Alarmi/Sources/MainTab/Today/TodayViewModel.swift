//
//  TodayViewModel.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class TodayViewModel: ObservableObject {

    @Published var pandaImageName: String = ""
    @Published var statusDescription: String = ""

    init() {}
}
