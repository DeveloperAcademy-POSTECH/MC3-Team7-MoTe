//
//  SettingLocationCollectionViewCell.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class RegisterLocationCollectionViewCell: UICollectionViewCell {

    // MARK: View

    private let countryNameStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    let flagLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.setDynamicFont(.largeTitle)
        return $0
    }(UILabel())

    let nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    let compareTimeLabel: UILabel = {
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
            countryNameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countryNameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
