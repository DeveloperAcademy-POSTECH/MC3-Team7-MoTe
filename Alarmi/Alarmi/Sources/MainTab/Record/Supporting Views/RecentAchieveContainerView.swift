//
//  RecentAccomplishView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

struct RecentAchieveModel {
    var purpose: [Bool]

    static let dummy = RecentAchieveModel(purpose: [true, true, true, false, true, true])
}
final class RecentAchieveContainerView: UIView {
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

    private lazy var circleView1: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView2: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView3: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView4: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView5: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView6: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView7: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView8: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView9: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var circleView10: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var percentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .body, weight: .semibold)
        return $0
    }(UILabel())

    var viewModel: RecentAchieveModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            circleViews.enumerated().forEach {
                guard viewModel.purpose.count > $0.offset else {
                    $0.element.backgroundColor = .systemGray
                    return
                }
                let didCall = viewModel.purpose[$0.offset]
                $0.element.backgroundColor = didCall ? .systemGreen : .systemRed
            }
            let success: Double = Double(viewModel.purpose.filter { $0 == true }.count)
            percentLabel.text = "\(Int((success / Double(viewModel.purpose.count) * 100)))%"
        }
    }

    lazy var circleViews: [UIView] = [
        circleView1,
        circleView2,
        circleView3,
        circleView4,
        circleView5,
        circleView6,
        circleView7,
        circleView8,
        circleView9,
        circleView10
    ]

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
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
        circleViews.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = .systemGreen
        }
    }

    private func layout() {
        addSubviews(titleLabel, percentLabel)
        addSubview(hStackView)
        circleViews.forEach {
            hStackView.addArrangedSubviews($0)

            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 20),
                $0.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
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
            percentLabel.centerYAnchor.constraint(equalTo: hStackView.centerYAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: hStackView.trailingAnchor, constant: 7),
            percentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
