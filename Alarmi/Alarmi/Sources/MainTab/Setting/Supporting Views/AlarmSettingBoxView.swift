//
//  AlarmSettingView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class AlarmSettingBoxView: UIView {
    
    // MARK: Views
    
    private let alarmRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let alarmAgainRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let alarmSettingVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let alarmRowLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = "알림"
        return $0
    }(UILabel())
    
    private let alarmAgainRowLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = "다시 알림"
        return $0
    }(UILabel())
    
    private lazy var alarmSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = .toggleOrange
        $0.isOn = true
        $0.addTarget(self, action: #selector(alarmSwitchToggled), for: .valueChanged)
        return $0
    }(UISwitch())
    
    private lazy var alarmAgainSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = .toggleOrange
        $0.isOn = true
        // TODO: Add Target
        return $0
    }(UISwitch())
    
    private let divider: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
        return $0
    }(UIView())
    
    // MARK: Property
    
    weak var viewModel: SettingViewModel?
    
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
        backgroundColor = .cellBackgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func layout() {
        addSubviews(alarmSettingVStack)
        
        alarmSettingVStack.addArrangedSubviews(alarmRowHStack, divider, alarmAgainRowHStack)
        alarmRowHStack.addArrangedSubviews(alarmRowLabel, alarmSwitch)
        alarmAgainRowHStack.addArrangedSubviews(alarmAgainRowLabel, alarmAgainSwitch)
        
        NSLayoutConstraint.activate([
            alarmRowHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            alarmRowHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            alarmAgainRowHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            alarmAgainRowHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alarmSettingVStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            alarmSettingVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            alarmSettingVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            alarmSettingVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

private extension AlarmSettingBoxView {
    
    @objc func alarmSwitchToggled() {
        viewModel?.alarmSwitchToggled(alarmSwitch.isOn)
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct AlarmSettingBoxViewRepresentable: UIViewRepresentable {
    typealias UIViewType = AlarmSettingBoxView
    
    func makeUIView(context: Context) -> AlarmSettingBoxView {
        AlarmSettingBoxView()
    }
    
    func updateUIView(_ uiView: AlarmSettingBoxView, context: Context) {
        
    }
}

struct AlarmSettingBoxView_Preview: PreviewProvider {
    static var previews: some View {
        AlarmSettingBoxViewRepresentable()
            .frame(width: 358, height: 94)
    }
}
#endif
