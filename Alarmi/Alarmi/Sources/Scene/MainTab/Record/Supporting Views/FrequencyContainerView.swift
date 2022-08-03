//
//  FrequencyContainerView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import SwiftUI
import UIKit

final class FrequencyContainerView: UIView {
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "빈도"
        $0.setDynamicFont(for: .title3, weight: .semibold)
        return $0
    }(UILabel())
    lazy var contentView = UIHostingController(rootView: FrequencyView(frequencyDataList: RecordViewModel.dummyFrequencyDataList))

    var frequencyDataList: [[Frequency]]? {
        didSet {
            guard let frequencyDataList = frequencyDataList else { return }
            subviews.forEach { $0.removeFromSuperview() }
            contentView = UIHostingController(rootView: FrequencyView(frequencyDataList: frequencyDataList))
            contentView.view.backgroundColor = .clear
            layout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        attribute()
        layout()
    }

    private func attribute() {
        self.backgroundColor = .cellBackgroundColor
        self.layer.cornerRadius = 10
        contentView.view.backgroundColor = .clear
    }

    private func layout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentView.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
