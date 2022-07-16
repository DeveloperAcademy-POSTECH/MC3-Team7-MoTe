//
//  SettingNotifyViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class SettingNotifyViewController: UIViewController {

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "마지막으로 전화한지 7일이 되면 알림을 보내드려요."
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var alarmSetView: AlarmSetView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alarmSwitchChanged = { [weak self] isOn in
            let canBeEdit: Bool = isOn
            self?.animateAlarmAgainSetView(canBeEdit)
        }
        return $0
    }(AlarmSetView())

    private lazy var alarmAgainSetView: AlarmAgainSetView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(AlarmAgainSetView())

    private let alarmAgainSetDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "저희가 적절한 간격으로 알림을 다시 보내드려요."
        $0.textColor = .secondaryLabel
        $0.textAlignment = .right
        $0.setDynamicFont(.footnote)
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    private func attribute() {
        setup()
        setupNavigationBar()
    }

    private func layout() {
        view.addSubviews(descriptionLabel, alarmSetView, alarmAgainSetView, alarmAgainSetDescriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            alarmSetView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            alarmSetView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            alarmSetView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            alarmSetView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            alarmAgainSetView.topAnchor.constraint(equalTo: alarmSetView.bottomAnchor, constant: 16),
            alarmAgainSetView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            alarmAgainSetView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            alarmAgainSetView.heightAnchor.constraint(greaterThanOrEqualToConstant: 205)
        ])

        NSLayoutConstraint.activate([
            alarmAgainSetDescriptionLabel.topAnchor.constraint(equalTo: alarmAgainSetView.bottomAnchor, constant: 8),
            alarmAgainSetDescriptionLabel.leadingAnchor.constraint(equalTo: alarmAgainSetView.leadingAnchor, constant: 16),
            alarmAgainSetDescriptionLabel.trailingAnchor.constraint(equalTo: alarmAgainSetView.trailingAnchor, constant: -16)
        ])
    }

    private func setup() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupNavigationBar() {
        title = "알림"
    }

    private func animateAlarmAgainSetView(_ canBeEdit: Bool) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = canBeEdit ? 1 : 0.25
            let isUserInteractionEnabled: Bool = canBeEdit
            
            self.alarmAgainSetView.layer.opacity = opacity
            self.alarmAgainSetDescriptionLabel.layer.opacity = opacity
            self.alarmAgainSetView.isUserInteractionEnabled = isUserInteractionEnabled
        }, completion: nil)
    }
}
