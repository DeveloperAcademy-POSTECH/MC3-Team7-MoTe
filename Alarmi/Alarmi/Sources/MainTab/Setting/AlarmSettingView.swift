//
//  AlarmSettingView.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class AlarmSettingView: UIView {
    
    // MARK: Views
    
    private let alarmRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let alarmAgainRowHStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
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
        $0.isOn = true
//        $0.addTarget(self, action: #selector(alarmSwitchValueChanged), for: .valueChanged)
        return $0
    }(UISwitch())
    
    private lazy var alarmAgainSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isOn = true
//        $0.addTarget(self, action: #selector(alarmSwitchValueChanged), for: .valueChanged)
        return $0
    }(UISwitch())
    
    private let divider: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
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
        
    }
    
    private func layout() {
        
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

struct AlarmSettingView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            AlarmSettingView()
        }
        .ignoresSafeArea()
    }
}
#endif
