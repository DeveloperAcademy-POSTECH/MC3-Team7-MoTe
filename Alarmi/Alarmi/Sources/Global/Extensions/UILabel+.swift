//
//  UILabel+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setDynamicFont(_ style: UIFont.TextStyle) {
        self.font = UIFont.preferredFont(forTextStyle: style)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
    }

    func setDynamicFont(for style: UIFont.TextStyle, weight: UIFont.Weight = .regular) {
        self.font = UIFont.preferredFont(for: style, weight: weight)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
    }
}
