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
