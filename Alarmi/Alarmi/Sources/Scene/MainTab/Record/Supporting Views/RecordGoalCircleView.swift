//
//  RecordGoalCircleView.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

struct RecordGoalCircleDdipViewModel {
    var color: UIColor

    init(_ model: CallDate) {
        color = model.isGoalSuccess ?.systemGreen : .systemRed
    }

    init(_ color: UIColor = .systemGray) {
        self.color = color
    }
}

final class RecordGoalCircleView: UIView {
    init(_ viewModel: RecordGoalCircleDdipViewModel) {
        super.init(frame: .zero)
        self.backgroundColor = viewModel.color
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
