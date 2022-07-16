//
//  SettingCompleteViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class SettingCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
}

#if DEBUG
import SwiftUI

struct SettingCompleteViewController_Preview: PreviewProvider {
    static var previews: some View {
        SettingCompleteViewController()
            .toPreview()
            .ignoresSafeArea()
    }
}
#endif
