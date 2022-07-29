//
//  GoalSettingCellView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class GoalSettingCellView: UIView {
    
    // MARK: Views
    
    private let goalPeriodLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = "7"
        return $0
    }(UILabel())
    
    private let goalPeriodDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.textColor = .secondaryLabel
        $0.text = "일에 한 번"
        return $0
    }(UILabel())
    
    private let goalPeriodStepper: UIStepper = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.value = 7
        $0.minimumValue = 1
        $0.maximumValue = 31
        $0.stepValue = 1
        return $0
    }(UIStepper())
    
    private let goalSettingRowView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: Property
    
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
            goalSettingRowView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            goalSettingRowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            goalSettingRowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalSettingRowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            goalPeriodLabel.topAnchor.constraint(equalTo: goalSettingRowView.topAnchor),
            goalPeriodLabel.leadingAnchor.constraint(equalTo: goalSettingRowView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goalPeriodDescriptionLabel.centerYAnchor.constraint(equalTo: goalPeriodLabel.centerYAnchor),
            goalPeriodDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: goalSettingRowView.leadingAnchor, constant: 34),
            goalPeriodDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: goalPeriodLabel.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            goalPeriodStepper.centerYAnchor.constraint(equalTo: goalPeriodLabel.centerYAnchor),
            goalPeriodStepper.trailingAnchor.constraint(equalTo: goalSettingRowView.trailingAnchor)
        ])
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct GoalSettingCellViewRepresentable: UIViewRepresentable {
    typealias UIViewType = GoalSettingCellView
    
    func makeUIView(context: Context) -> GoalSettingCellView {
        GoalSettingCellView()
    }
    
    func updateUIView(_ uiView: GoalSettingCellView, context: Context) {
        
    }
}

struct GoalSettingCellView_Preview: PreviewProvider {
    static var previews: some View {
        GoalSettingCellViewRepresentable()
    }
}
#endif
