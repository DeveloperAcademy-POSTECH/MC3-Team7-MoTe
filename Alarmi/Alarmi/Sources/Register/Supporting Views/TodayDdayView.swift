//
//  TodayDdayView.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol TodayDdayViewDelegate: AnyObject {
    func presentCallDelayViewController()
}

final class TodayDdayView: UIView {

    struct State {
        var buttonName: String
        var descriptionLabelName: String
        var dDayLabel: String
    }

    // MARK: View

    private let dDayStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 7
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let dDayLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .largeTitle, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let callButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.titleAlignment = .center
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 15, bottom: 15, trailing: 11)
        $0.layer.cornerRadius = 10
        $0.addTarget(TodayDdayView.self, action: #selector(contactButtonTapped), for: .touchUpInside)
        var container = AttributeContainer()
        container.font = UIFont.preferredFont(forTextStyle: .body)
        return $0
    }(UIButton(configuration: .filled()))

    weak var delegate: TodayDdayViewDelegate?

    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func attribute() {}

    func set(state: State) {
        callButton.configuration?.attributedTitle = AttributedString(state.buttonName, attributes: AttributeContainer())
        descriptionLabel.text = state.descriptionLabelName
        dDayLabel.text = state.dDayLabel
    }

    private func layout() {
        addSubview(dDayStackView)
        dDayStackView.addArrangedSubviews(descriptionLabel, dDayLabel, callButton)

        NSLayoutConstraint.activate([
            dDayStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dDayStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            dDayStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dDayStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

extension TodayDdayView {

    // MARK: Button Action

    @objc private func delayButtonTapped() {
        delegate?.presentCallDelayViewController()
    }

    @objc private func contactButtonTapped() {
        // TODO: 바꿔야함
        delegate?.presentCallDelayViewController()
    }
}
