//
//  CallTimeCellView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class CallTimeCellView: UIView {
    
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
        $0.distribution = .fill
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
    
    private let startTimePicker: UIDatePicker = {
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .time
        $0.minuteInterval = 10
        return $0
    }(UIDatePicker())
    
    private let endTimePicker: UIDatePicker = {
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .time
        $0.minuteInterval = 10
        return $0
    }(UIDatePicker())
    
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
        
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct CallTimeCellViewRepresentable: UIViewRepresentable {
    typealias UIViewType = CallTimeCellView
    
    func makeUIView(context: Context) -> CallTimeCellView {
        CallTimeCellView()
    }
    
    func updateUIView(_ uiView: CallTimeCellView, context: Context) {
        
    }
}

struct CallTimeCellView_Preview: PreviewProvider {
    static var previews: some View {
        CallTimeCellViewRepresentable()
    }
}
#endif

