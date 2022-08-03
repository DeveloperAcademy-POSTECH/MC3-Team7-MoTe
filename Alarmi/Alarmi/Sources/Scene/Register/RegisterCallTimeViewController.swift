//
//  CallTimeViewController.swift
//  Alarmi
//
//  Created by kwon ji won on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

protocol RegisterCallTimeViewControllerDelegate: AnyObject {
    func gotoRegisterCompleteViewController()
}

class RegisterCallTimeViewController: UIViewController {
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var startTimeViewLabel: UILabel!
    
    var viewModel: RegisterViewModel!
    private var cancelBag = Set<AnyCancellable>()

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "완료"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    private func attribute() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "전화 시간"
        startTimeViewLabel.text = Date.koreanDefulatCallStartTimeCurrentDate.date2TimeString()
        startTimePicker.date = Date.koreanDefulatCallStartTimeCurrentDate
        endTimePicker.date = Date.koreanDefulatCallEndTimeCurrentDate
    }

    private func layout() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction func startTimePickerAction(_ sender: UIDatePicker) {
        viewModel.startTimeDate.send(sender.date)
        startTimeViewLabel.text = sender.date.date2TimeString()
    }

    @IBAction func endTimePickerAction(_ sender: UIDatePicker) {
        viewModel.endTimeDate.send(sender.date)
    }
}

extension RegisterCallTimeViewController {

    @objc private func buttonDidTap() {
        viewModel.callTimeNextButtonDidTap.send(Void())
    }
}
