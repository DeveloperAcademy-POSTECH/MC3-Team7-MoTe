//
//  SettingLocationCollectionViewCell.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class SettingLocationCollectionViewCell: UICollectionViewCell {

    // MARK: View

    private lazy var countryNameStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    private lazy var flagLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "🇺🇸"
        $0.textAlignment = .center
        $0.setDynamicFont(.largeTitle)
        return $0
    }(UILabel())

    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "미국"
        $0.textAlignment = .center
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var compareTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "도시마다 달라요"
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
        $0.setDynamicFont(.footnote)
        return $0
    }(UILabel())
}
}
