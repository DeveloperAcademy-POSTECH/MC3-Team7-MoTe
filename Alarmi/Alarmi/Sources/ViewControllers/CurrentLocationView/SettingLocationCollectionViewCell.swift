//
//  SettingLocationCollectionViewCell.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class SettingLocationCollectionViewCell: UICollectionViewCell {

    // MARK: View

    private lazy var countryNameStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    lazy var flagLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.setDynamicFont(.largeTitle)
        return $0
    }(UILabel())

    lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    lazy var compareTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
        $0.setDynamicFont(.footnote)
        return $0
    }(UILabel())

    // MARK: method

    func setup() {
        layout()
    }

    private func layout() {
        contentView.addSubviews(countryNameStack)
        countryNameStack.addArrangedSubviews(flagLabel, nameLabel, compareTimeLabel)

        NSLayoutConstraint.activate([
            countryNameStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryNameStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryNameStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            countryNameStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
