//
//  CallTimeCellView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class CallTimeSettingBoxView: UIView {
    
    // MARK: Views
    
    private let startTimeRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let endTimeRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let cellVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let startTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = "시작 시간"
        return $0
    }(UILabel())
    
    private let endTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.body)
        $0.text = "종료 시간"
        return $0
    }(UILabel())
    
    private lazy var startTimePicker: UIDatePicker = {
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .time
        $0.minuteInterval = 10
        $0.addTarget(self, action: #selector(startTimePickerDidChanged), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    private lazy var endTimePicker: UIDatePicker = {
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .time
        $0.minuteInterval = 10
        $0.addTarget(self, action: #selector(endTimePickerDidChanged), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    private let divider: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
        return $0
    }(UIView())
    
    // MARK: Property
    
    weak var viewModel: SettingViewModel?
    
    var callStartTime: Date? {
        didSet {
            guard let callStartTime = callStartTime else { return }
            startTimePicker.date = callStartTime
        }
    }
    
    var callEndTime: Date? {
        didSet {
            guard let callEndTime = callEndTime else { return }
            endTimePicker.date = callEndTime
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
        addSubviews(cellVStack)
        
        startTimeRowHStack.addArrangedSubviews(startTimeLabel, startTimePicker)
        endTimeRowHStack.addArrangedSubviews(endTimeLabel, endTimePicker)
        cellVStack.addArrangedSubviews(startTimeRowHStack, divider, endTimeRowHStack)
        
        NSLayoutConstraint.activate([
            startTimeRowHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            startTimeRowHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            endTimeRowHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            endTimeRowHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cellVStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cellVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            cellVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    @objc private func startTimePickerDidChanged() {
        viewModel?.startTimePickerDidChanged(startTimePicker.date)
    }
    
    @objc private func endTimePickerDidChanged() {
        viewModel?.endTimePickerDidChanged(endTimePicker.date)
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct CallTimeSettingBoxViewRepresentable: UIViewRepresentable {
    typealias UIViewType = CallTimeSettingBoxView
    
    func makeUIView(context: Context) -> CallTimeSettingBoxView {
        CallTimeSettingBoxView()
    }
    
    func updateUIView(_ uiView: CallTimeSettingBoxView, context: Context) {
        
    }
}

struct CallTimeSettingBoxView_Preview: PreviewProvider {
    static var previews: some View {
        CallTimeSettingBoxViewRepresentable()
            .frame(width: 358, height: 120)
    }
}
#endif
