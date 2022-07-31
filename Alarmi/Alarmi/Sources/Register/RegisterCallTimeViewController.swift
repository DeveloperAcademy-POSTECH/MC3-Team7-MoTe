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
    func gotoRegisterPlanViewController()
}

class RegisterCallTimeViewController: UIViewController {
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var startTimeTransferredLabel: UILabel!
    @IBOutlet weak var endTimeTransferredLabel: UILabel!

    weak var delegate: RegisterCallTimeViewControllerDelegate?

    var viewModel = RegisterCallTimeViewModel()
    private var cancelBag = Set<AnyCancellable>()

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()
    }

    private func bind() {
    }

    private func attribute() {
        configureNavigationBar()
        configureBackground()
    }
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "전화 시간"
    }
    
    private func configureBackground() {
        view.backgroundColor = .systemGroupedBackground
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

        viewModel.startTimePickerAction(sender.date)

    }

    @IBAction func endTimePickerAction(_ sender: UIDatePicker) {
        viewModel.endTimePickerAction(sender.date)

    }
}

extension RegisterCallTimeViewController {

    @objc private func buttonDidTap() {

        delegate?.gotoRegisterPlanViewController()
        viewModel.storeCallTime()
    }
}
