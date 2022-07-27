//
//  PlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class PlanViewController: UIViewController {

    // MARK: IBoutlet

    // MARK: View

    // MARK: Store Property

    private let viewModel = PlanViewModel()
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
