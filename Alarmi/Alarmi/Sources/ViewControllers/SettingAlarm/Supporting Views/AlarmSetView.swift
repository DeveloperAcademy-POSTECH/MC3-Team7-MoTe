//
//  AlarmSetView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class AlarmSetView: UIView {

    // MARK: Views

    private let vStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())

    private let hStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.title2)
        $0.text = "알림"
        return $0
    }(UILabel())

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .secondaryLabel
        $0.setDynamicFont(.footnote)
        $0.text = "목표일의 전화 시간에 알림을 보냅니다."
        return $0
    }(UILabel())

    private let alarmSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isOn = true
        return $0
    }(UISwitch())

    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func attribute() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    private func layout() {
        addSubviews(hStackView)

        vStackView.addArrangedSubviews(titleLabel, descriptionLabel)

        hStackView.addArrangedSubviews(vStackView, alarmSwitch)

        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

    }
}
