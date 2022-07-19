//
//  RecordViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class RecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
    }

    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
        title = "기록"
    }
}
