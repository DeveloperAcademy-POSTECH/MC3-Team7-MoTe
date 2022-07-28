//
//  SettingViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class SettingViewController: UIViewController {

    // MARK: IBoutlet

    // MARK: View

    // MARK: Store Property

    private let viewModel = SettingViewModel()
    private let cancelBag = Set<AnyCancellable>()

    // MARK: LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    // MARK: IBAction

    // MARK: Method

    func attribute() {

    }

    func layout() {

    }
}
