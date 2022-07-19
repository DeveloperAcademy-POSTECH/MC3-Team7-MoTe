//
//  UIFont+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/17.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

extension UIFont {

    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {

        let traits = UITraitCollection(preferredContentSizeCategory: .large)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traits)

        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)

        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }

}
