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
