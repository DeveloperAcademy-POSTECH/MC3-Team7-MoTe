//
//  SettingViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class SettingViewController: UIViewController {

    // MARK: View
    
    private let settingListScrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    private let settingListVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 32
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let callTimeSettingVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let callTimeSettingTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .title3, weight: .bold)
        $0.text = "전화 시간 설정"
        return $0
    }(UILabel())
    
    private lazy var callTimeCellView: CallTimeCellView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CallTimeCellView())
    
    private let callTimeSettingDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.caption1)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.text = "알림을 설정하면 목표일의 이 시간대에 알림을 보내드려요."
        return $0
    }(UILabel())
    
    private let alarmSettingVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let alarmSettingTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .title3, weight: .bold)
        $0.text = "알림 설정"
        return $0
    }(UILabel())
    
    private lazy var alarmSettingView: AlarmSettingCellView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(AlarmSettingCellView())
    
    private let alarmSettingDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.caption1)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.text = "알림이 온 이후에 전화를 기록하지 않으면,\n전화 시간 종료 전에 알림을 총 6번 보내드려요."
        return $0
    }(UILabel())

    // MARK: Store Property

    private let viewModel = SettingViewModel()
    private let cancelBag = Set<AnyCancellable>()

    // MARK: LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    // MARK: Method

    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
        setNavigationBar()
    }

    private func layout() {
        view.addSubviews(settingListVStack)
        
        settingListLayout()
        alarmSettingLayout()
        callTimeSettingLayout()
    }
    
    private func setNavigationBar() {
        title = "설정"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func settingListLayout() {
        settingListVStack.addArrangedSubviews(
            callTimeSettingVStack,
            alarmSettingVStack
        )
        
        NSLayoutConstraint.activate([
            settingListVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingListVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingListVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func alarmSettingLayout() {
        alarmSettingVStack.addArrangedSubviews(
            alarmSettingTitleLabel,
            alarmSettingView,
            alarmSettingDescriptionLabel
        )
        
        NSLayoutConstraint.activate([
            alarmSettingVStack.topAnchor.constraint(equalTo: callTimeSettingVStack.bottomAnchor, constant: 32),
            alarmSettingVStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            alarmSettingVStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alarmSettingView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            alarmSettingView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alarmSettingDescriptionLabel.trailingAnchor.constraint(equalTo: alarmSettingView.trailingAnchor, constant: -16)
        ])
    }
    
    private func callTimeSettingLayout() {
        callTimeSettingVStack.addArrangedSubviews(
            callTimeSettingTitleLabel,
            callTimeCellView,
            callTimeSettingDescriptionLabel
        )
        
        NSLayoutConstraint.activate([
            callTimeSettingVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            callTimeSettingVStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            callTimeSettingVStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            callTimeCellView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            callTimeCellView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            callTimeSettingDescriptionLabel.trailingAnchor.constraint(equalTo: callTimeCellView.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct SettingViewController_Preview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: SettingViewController())
            .toPreview()
            .ignoresSafeArea()
    }
}
#endif
