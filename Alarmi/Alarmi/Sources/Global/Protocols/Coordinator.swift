//
//  Coordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
