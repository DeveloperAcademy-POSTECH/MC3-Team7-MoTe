//
//  PuporseContainerView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class PurposeBoardView: UIView {
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Goal Achievement Count"
        $0.setDynamicFont(for: .title3, weight: .semibold)
        return $0
    }(UILabel())

    private lazy var hStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .equalCentering
        $0.alignment = .center
        return $0
    }(UIStackView())

    private lazy var circleView1: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemIndigo
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = true
        return $0
    }(UIView())

    private lazy var numberLabel1: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 34)
        $0.textColor = .white
        return $0
    }(UILabel())

    private lazy var descriptionLabel1: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.callout)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var circleView2: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = true
        return $0
    }(UIView())

    private lazy var numberLabel2: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 34)
        $0.textColor = .white
        return $0
    }(UILabel())

    private lazy var descriptionLabel2: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.callout)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    var goalCount: Int? {
        didSet {
            guard let goalCount = goalCount else { return }
            numberLabel1.text = "\(goalCount)"
            descriptionLabel1.text = "Achieved goals\nfor\(goalCount) times."
        }
    }

    var goalCombo: Int? {
        didSet {
            guard let goalCombo = goalCombo else { return }
            numberLabel2.text = "\(goalCombo)"
            descriptionLabel2.text = "Max Combo:\n \(goalCombo)times in a row."
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
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
    }

    private func layout() {
        addSubviews(titleLabel, hStackView, circleView1, circleView2)
        hStackView.addArrangedSubviews(descriptionLabel1, descriptionLabel2)
        circleView1.addSubview(numberLabel1)
        circleView2.addSubview(numberLabel2)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            circleView1.widthAnchor.constraint(equalToConstant: 80),
            circleView1.heightAnchor.constraint(equalToConstant: 80),
            circleView2.widthAnchor.constraint(equalToConstant: 80),
            circleView2.heightAnchor.constraint(equalToConstant: 80)

        ])
        NSLayoutConstraint.activate([
            numberLabel1.centerXAnchor.constraint(equalTo: circleView1.centerXAnchor),
            numberLabel1.centerYAnchor.constraint(equalTo: circleView1.centerYAnchor),
            numberLabel2.centerXAnchor.constraint(equalTo: circleView2.centerXAnchor),
            numberLabel2.centerYAnchor.constraint(equalTo: circleView2.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            hStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            hStackView.topAnchor.constraint(equalTo: circleView1.bottomAnchor, constant: 10),
            hStackView.topAnchor.constraint(equalTo: circleView2.bottomAnchor, constant: 10),

            circleView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            circleView2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            descriptionLabel1.centerXAnchor.constraint(equalTo: circleView1.centerXAnchor),
            descriptionLabel1.leadingAnchor.constraint(equalTo: circleView1.leadingAnchor, constant: -20),
            descriptionLabel1.trailingAnchor.constraint(equalTo: circleView1.trailingAnchor, constant: 20),

            descriptionLabel2.centerXAnchor.constraint(equalTo: circleView2.centerXAnchor),
            descriptionLabel2.leadingAnchor.constraint(equalTo: circleView2.leadingAnchor, constant: -20),
            descriptionLabel2.trailingAnchor.constraint(equalTo: circleView2.trailingAnchor, constant: 20)

        ])
    }
}
