//
//  TodayDdayView.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/29.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit
import SwiftDate

protocol TodayDdayViewDelegate: AnyObject {
    func buttonDidTap(_ type: TodayDdayView.DDayType)
}

struct TodayDDayDdipViewModel {
    var dday: String = "-"
    var color: UIColor? = .tintColor

    init() {}
    init(dday: String, color: UIColor = .tintColor) {
        self.dday = dday
        self.color = color
    }
    init(_ model: GoalDate) {
        guard let dDayInt = Date().fullDistance(
            from: model,
            resultIn: .day
        ) else { return }

        var dDayString = "-"
        var color: UIColor? = .tintColor
        if model.isToday {
            dDayString = "오늘"
        } else if dDayInt > 0 {
            dDayString = "D-\(dDayInt+1)"
        } else if dDayInt == 0 {
            dDayString = "D-1"
        } else {
            dDayString = "D+\(abs(dDayInt))"
            color = .goalDateRed
        }
       
        self.dday = dDayString
        self.color = color
    }
    init(_ model: CallDate) {
        guard let dDayInt = Date().fullDistance(
            from: model.date,
            resultIn: .day
        ) else { return }

        var dDayString = "-"
        if dDayInt > 0 {
            dDayString = "D+\(dDayInt)"
        } else if dDayInt == 0 {
            dDayString = "오늘"
        } else {
            dDayString = "D-\(abs(dDayInt))"
        }
        self.dday = dDayString
    }
}

final class TodayDdayView: UIView {

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .body, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .tintColor
        return $0
    }(UILabel())

    private let dDayLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 50, weight: .bold)
        $0.textColor = .systemIndigo
        $0.textAlignment = .center
        $0.text = "D+0"
        $0.textColor = .tintColor
        return $0
    }(UILabel())

    private lazy var button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration?.baseBackgroundColor = .systemIndigo
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16)
        $0.configuration?.cornerStyle = .medium
        $0.configuration?.baseBackgroundColor = .tintColor
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(UIButton(configuration: .filled()))

    weak var delegate: TodayDdayViewDelegate?

    private var type: DDayType = .lastCall

    convenience init(type: DDayType) {
        self.init()
        self.type = type
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.configuration?.attributedTitle = AttributedString(
            type.buttonName,
            attributes: container
        )
        titleLabel.text = type.title
        layout()
    }

    func update(with viewModel: TodayDDayDdipViewModel) {
        dDayLabel.textColor = viewModel.color
        dDayLabel.text = viewModel.dday

        if type != .lastCall {
            type = viewModel.dday.contains("+") ? .delay : .nextGoal
            titleLabel.text = type.title
        }

//        if type != .lastCall {
//            type = viewModel.isBefore ? .delay : .nextGoal
//            self.titleLabel.text = type.title
//
//            if type == .delay {
//                self.dDayLabel.textColor = viewModel.isBefore ? .goalDateRed : .tintColor
//            }
//        }
//
//        self.dDayLabel.textColor = viewModel.isBefore ? .goalDateRed : .tintColor
//        self.dDayLabel.text = "D\(viewModel.isBefore ? "+" : "-")\(viewModel.dday)"
    }

    func updateButton(_ didCall: Bool) {
        button.configuration?.baseBackgroundColor = didCall ? .systemGray : .tintColor
        button.isUserInteractionEnabled = !didCall
    }

    private func layout() {
        addSubviews(titleLabel, dDayLabel, button)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            dDayLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dDayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            button.topAnchor.constraint(equalTo: dDayLabel.bottomAnchor, constant: 7),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

extension TodayDdayView {

    @objc private func buttonDidTap() {
        delegate?.buttonDidTap(type)
    }
}

extension TodayDdayView {

    enum DDayType {
        case lastCall
        case nextGoal
        case delay

        var buttonName: String {
            switch self {
            case .lastCall:
                return "전화했어요"
            case .nextGoal:
                return "미룰거예요"
            case .delay:
                return "미룰거예요"
            }
        }

        var title: String {
            switch self {
            case .lastCall:
                return "마지막 전화"
            case .nextGoal:
                return "다음 목표일"
            case .delay:
                return "목표일로부터"
            }
        }
    }

}
