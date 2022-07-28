//
//  UserDefaultable.swift
//  Alarmi
//
//  Created by Woody on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

protocol UserDefaultsManager {
    associatedtype T: Codable

    var data: T? { get }

    var isEmpty: Bool { get }

    func save<T>(_:T)

    func removeAll()
}
