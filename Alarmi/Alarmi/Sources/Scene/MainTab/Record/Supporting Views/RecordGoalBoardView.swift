//
//  RecentAccomplishView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class RecordGoalBoardView: UIView {
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "최근 10회 달성률"
        $0.setDynamicFont(for: .title3, weight: .semibold)
        return $0
    }(UILabel())

    private lazy var hStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .equalCentering
        $0.alignment = .center
        return $0
    }(UIStackView())

    private lazy var goalPercentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .body, weight: .semibold)
        $0.text = "%"
        return $0
    }(UILabel())

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

    func updateCircleViews(with recordGoalCircleDdipViewModel: [RecordGoalCircleDdipViewModel]) {
        hStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let views = recordGoalCircleDdipViewModel.map(RecordGoalCircleView.init)

        let widthConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 20) }
        let heightConstraints = views.map { $0.widthAnchor.constraint(equalToConstant: 20) }
        let constraints: [NSLayoutConstraint] = widthConstraints + heightConstraints
        NSLayoutConstraint.activate(constraints)
        views.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            hStackView.addArrangedSubviews($0)
        }
    }

    func updateGoalPercentLabel(with goalPercent: Int) {
        self.goalPercentLabel.text = "\(goalPercent)%"
    }

    private func attribute() {
        self.backgroundColor = .cellBackgroundColor
        self.layer.cornerRadius = 10
    }

    private func layout() {
        addSubviews(titleLabel, goalPercentLabel)
        addSubview(hStackView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            hStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            goalPercentLabel.centerYAnchor.constraint(equalTo: hStackView.centerYAnchor),
            goalPercentLabel.leadingAnchor.constraint(equalTo: hStackView.trailingAnchor, constant: 7),
            goalPercentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
