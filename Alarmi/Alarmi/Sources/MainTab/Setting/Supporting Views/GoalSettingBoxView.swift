//
//  GoalSettingCellView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class GoalSettingBoxView: UIView {
    
    // MARK: Views
    
    private lazy var goalPeriodLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = String(viewModel?.goalPeriod ?? 7)
        return $0
    }(UILabel())
    
    private let goalPeriodDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.textColor = .secondaryLabel
        $0.text = "일에 한 번"
        return $0
    }(UILabel())
    
    private lazy var goalPeriodStepper: UIStepper = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.value = Double(viewModel?.goalPeriod ?? 7)
        $0.minimumValue = 1
        $0.maximumValue = 31
        $0.stepValue = 1
        $0.addTarget(
            self,
            action: #selector(goalPeriodStepperDidChanged(_:)),
            for: .valueChanged
        )
        return $0
    }(UIStepper())
    
    private let goalSettingRowView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: Property
    
    weak var viewModel: SettingViewModel?
    
    var goalPeriod: Int? {
        didSet {
            guard let goalPeriod = goalPeriod else { return }
            goalPeriodLabel.text = String(goalPeriod)
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
        backgroundColor = .cellBackgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func layout() {
        addSubviews(goalSettingRowView)
        goalSettingRowView.addSubviews(
            goalPeriodLabel,
            goalPeriodDescriptionLabel,
            goalPeriodStepper
        )
        
        NSLayoutConstraint.activate([
            goalPeriodLabel.centerYAnchor.constraint(equalTo: goalSettingRowView.centerYAnchor),
            goalPeriodLabel.leadingAnchor.constraint(equalTo: goalSettingRowView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goalPeriodDescriptionLabel.centerYAnchor.constraint(equalTo: goalPeriodLabel.centerYAnchor),
            goalPeriodDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 46),
            goalPeriodDescriptionLabel.leadingAnchor.constraint(equalTo: goalPeriodLabel.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            goalPeriodStepper.centerYAnchor.constraint(equalTo: goalPeriodLabel.centerYAnchor),
            goalPeriodStepper.trailingAnchor.constraint(equalTo: goalSettingRowView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goalSettingRowView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            goalSettingRowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            goalSettingRowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalSettingRowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            goalSettingRowView.heightAnchor.constraint(equalTo: goalPeriodLabel.heightAnchor),
            goalSettingRowView.heightAnchor.constraint(greaterThanOrEqualTo: goalPeriodStepper.heightAnchor)
        ])
    }
    
    @objc private func goalPeriodStepperDidChanged(_ sender: UIStepper!) {
        viewModel?.goalPeriodStepperDidChanged(Int(sender.value))
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct GoalSettingBoxViewRepresentable: UIViewRepresentable {
    typealias UIViewType = GoalSettingBoxView
    
    func makeUIView(context: Context) -> GoalSettingBoxView {
        GoalSettingBoxView()
    }
    
    func updateUIView(_ uiView: GoalSettingBoxView, context: Context) {
        
    }
}

struct GoalSettingBoxView_Preview: PreviewProvider {
    static var previews: some View {
        GoalSettingBoxViewRepresentable()
    }
}
#endif
