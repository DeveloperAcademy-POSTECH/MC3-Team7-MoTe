//
//  AMButton.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

/// AMButton
///
/// height가 고정되어있습니다. 상좌우 constraint를 잡아주세요.
final class AMButton: UIButton {

    var title: String = "" {
        didSet {
            configuration?.title = title
        }
    }

    convenience init() {
        self.init(configuration: .filled())

        attribute()
        layout()
    }

    private func attribute() {
        configuration?.baseBackgroundColor = .tintColor
        configuration?.titleAlignment = .center
        configuration?.cornerStyle = .medium
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
