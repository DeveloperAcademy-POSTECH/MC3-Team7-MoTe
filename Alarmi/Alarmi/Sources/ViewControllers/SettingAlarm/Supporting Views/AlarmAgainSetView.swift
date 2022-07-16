//
//  AlarmAgainView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class AlarmAgainSetView: UIView {

    // MARK: Views

    private let vStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fillProportionally
        $0.alignment = .leading
        return $0
    }(UIStackView())

    private let hStackView1: UIStackView = {
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
        $0.text = "다시 알림"
        return $0
    }(UILabel())

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .secondaryLabel
        $0.setDynamicFont(.footnote)
        $0.text = "알림이 온 이후 전화를 기록하지 않으면,\n알림을 다시 보냅니다."
        return $0
    }(UILabel())

    private lazy var alarmSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isOn = true
        $0.addTarget(self, action: #selector(alarmSwitchValueChanged), for: .valueChanged)
        return $0
    }(UISwitch())

    private let subTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "횟수"
        $0.setDynamicFont(.headline)
        return $0
    }(UILabel())

    private let hStackView2: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 6
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    private let minLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "2"
        $0.setDynamicFont(.callout)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    private let maxLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "10"
        $0.setDynamicFont(.callout)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    private lazy var slider: UISlider = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.minimumValue = 2
        $0.maximumValue = 10
        $0.value = 6
        $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return $0
    }(UISlider())

    private let sliderLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "최대 6번 알림을 다시 받을게요."
        $0.textAlignment = .center
        return $0
    }(UILabel())

    // MARK: Parameters

    private var alarmAgainCount: Int = 5 {
        didSet {
            sliderLabel.text = "최대 \(alarmAgainCount)번 알림을 다시 받을게요."
        }
    }

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
        addSubviews(hStackView1, subTitleLabel, hStackView2, sliderLabel)

        vStackView.addArrangedSubviews(titleLabel, descriptionLabel)

        hStackView1.addArrangedSubviews(vStackView, alarmSwitch)

        hStackView2.addArrangedSubviews(minLabel, slider, maxLabel)

        NSLayoutConstraint.activate([
            hStackView1.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStackView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStackView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: hStackView1.bottomAnchor, constant: 16),
            subTitleLabel.leadingAnchor.constraint(equalTo: hStackView1.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            hStackView2.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 8),
            hStackView2.leadingAnchor.constraint(equalTo: hStackView1.leadingAnchor),
            hStackView2.trailingAnchor.constraint(equalTo: hStackView1.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            sliderLabel.topAnchor.constraint(equalTo: hStackView2.bottomAnchor, constant: 8),
            sliderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            sliderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderLabel.leadingAnchor.constraint(equalTo: hStackView1.leadingAnchor),
            sliderLabel.trailingAnchor.constraint(equalTo: hStackView1.trailingAnchor)
        ])
    }

    private func animateSliderView(_ canBeEdit: Bool) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = canBeEdit ? 1 : 0.25
            let isUserInteractionEnabled: Bool = canBeEdit
            
            self.subTitleLabel.layer.opacity = opacity
            self.slider.layer.opacity = opacity
            self.sliderLabel.layer.opacity = opacity
            self.slider.isUserInteractionEnabled = isUserInteractionEnabled
        }, completion: nil)
    }

}

extension AlarmAgainSetView {

    @objc private func alarmSwitchValueChanged() {
        let isOn: Bool = alarmSwitch.isOn
        animateSliderView(isOn)
    }

    @objc private func sliderValueChanged() {
        alarmAgainCount = Int(slider.value)
    }
}
