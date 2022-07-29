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

