//
//  aViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class aViewController: UIViewController {

    // MARK: IBoutlet

    // MARK: View

    // MARK: Store Property

    private let viewModel = aViewModel()
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
