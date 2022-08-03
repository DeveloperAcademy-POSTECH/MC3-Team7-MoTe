//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

protocol RegisterPlanViewControllerDelegate: AnyObject {
    func gotoRegisterCallTimeViewController()
}

final class RegisterPlanViewController: UIViewController {
    
    @IBOutlet private var startDatePicker: UIDatePicker!
    @IBOutlet private var containerViews: [UIView]!
    @IBOutlet private var settingDayLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var settingDayStepper: UIStepper!

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    var viewModel: RegisterViewModel!
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()
    }

    private func bind() {
        viewModel.$callPeriod
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.settingDayLabel.text = String($0)
            }
            .store(in: &cancelBag)
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        startDatePicker.minimumDate = Date()
        settingDayStepper.value = Double(viewModel.callPeriod)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "목표"
    }

    private func layout() {

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction private func settingDayStepper(_ sender: UIStepper) {
        viewModel.dayStepper.send(Int(sender.value))
    }

    @IBAction private func settingStartDatePicker(_ sender: UIDatePicker) {
        viewModel.startDate = sender.date
    }
}

extension RegisterPlanViewController {
    @objc private func buttonDidTap() {
        viewModel.goalNextButtonDidTap.send(Void())
    }
}
