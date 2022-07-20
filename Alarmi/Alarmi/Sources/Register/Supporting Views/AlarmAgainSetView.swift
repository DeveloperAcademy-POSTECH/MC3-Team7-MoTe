//
//  AlarmAgainView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol AlarmAgainSetViewProtocol: AnyObject {
    func reAlarmSwitchDidValueChanged(_ isOn: Bool)
    func sliderDidValueChanged(_ value: Int)
}

final class AlarmAgainSetView: UIView {

    // MARK: Views

    private let vStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
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
        $0.setDynamicFont(for: .title2, weight: .bold)
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

    private let hStackView2: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())

    private lazy var minLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "\(minAlarmCount)"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    private lazy var maxLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "\(maxAlarmCount)"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    private lazy var slider: UISlider = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.minimumValue = Float(minAlarmCount)
        $0.maximumValue = Float(maxAlarmCount)
        $0.value = 6
        $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return $0
    }(UISlider())

    private lazy var sliderLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "최대 \(alarmAgainCount)번 알림을 다시 받을게요."
        $0.textAlignment = .center
        return $0
    }(UILabel())

    // MARK: Parameters

    weak var delegate: AlarmAgainSetViewProtocol?

    private var alarmAgainCount: Int = 6 {
        didSet {
            sliderLabel.text = "최대 \(alarmAgainCount)번 알림을 다시 받을게요."
        }
    }

    private let minAlarmCount: Int = 2

    private let maxAlarmCount: Int = 10

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
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    private func layout() {
        addSubviews(hStackView1, hStackView2, sliderLabel)

        vStackView.addArrangedSubviews(titleLabel, descriptionLabel)

        hStackView1.addArrangedSubviews(vStackView, alarmSwitch)

        hStackView2.addArrangedSubviews(minLabel, slider, maxLabel)

        NSLayoutConstraint.activate([
            hStackView1.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStackView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStackView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            sliderLabel.topAnchor.constraint(equalTo: hStackView1.bottomAnchor, constant: 16),
            sliderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderLabel.leadingAnchor.constraint(equalTo: hStackView1.leadingAnchor),
            sliderLabel.trailingAnchor.constraint(equalTo: hStackView1.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            hStackView2.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 8),
            hStackView2.leadingAnchor.constraint(equalTo: hStackView1.leadingAnchor),
            hStackView2.trailingAnchor.constraint(equalTo: hStackView1.trailingAnchor),
            hStackView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])

    }

    private func animateSliderView(_ canBeEdit: Bool) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = canBeEdit ? 1 : 0.4
            let isUserInteractionEnabled: Bool = canBeEdit

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
        delegate?.reAlarmSwitchDidValueChanged(isOn)
    }

    @objc private func sliderValueChanged() {
        let value: Int = Int(slider.value)
        alarmAgainCount = Int(value)
        delegate?.sliderDidValueChanged(value)
    }
}
