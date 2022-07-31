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

    // MARK: View - 설정 목록
    
    private let settingListScrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
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
    
    // MARK: View - 목표 설정
    
    private let goalSettingVStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
        return $0
    }(UIStackView())
    
    private let goalSettingTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(for: .title3, weight: .bold)
        $0.text = "목표 설정"
        return $0
    }(UILabel())
    
    private lazy var goalSettingBoxView: GoalSettingBoxView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.viewModel = viewModel
        return $0
    }(GoalSettingBoxView())
    
    private let goalSettingDescriptionLabel: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.caption1)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.text = "알림을 설정하면 목표일마다 알림을 보내드려요."
        return $0
    }(UILabel())
    
    // MARK: View - 전화 시간 설정
    
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
    
    private lazy var callTimeBoxView: CallTimeSettingBoxView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CallTimeSettingBoxView())
    
    private let callTimeSettingDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.caption1)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.text = "알림을 설정하면 목표일의 이 시간대에 알림을 보내드려요."
        return $0
    }(UILabel())
    
    // MARK: View - 알림 설정
    
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
    
    private lazy var alarmSettingBoxView: AlarmSettingBoxView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.viewModel = viewModel
        return $0
    }(AlarmSettingBoxView())
    
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
    private var cancelBag = Set<AnyCancellable>()

    // MARK: LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()
    }
    
    // MARK: Method
    
    private func bind() {
        viewModel.$goalPeriod
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.goalSettingBoxView.goalPeriod = $0
            }
            .store(in: &cancelBag)
    }

    private func attribute() {
        view.backgroundColor = .backgroundColor
        setNavigationBar()
    }

    private func setNavigationBar() {
        title = "설정"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: Layout Method

private extension SettingViewController {
    
    func layout() {
        view.addSubviews(settingListScrollView)
        
        setSettingListScrollViewLayout()
        setSettingListVStackLayout()
        setGoalSettingLayout()
        setCallTimeSettingLayout()
        setAlarmSettingLayout()
    }
    
    func setSettingListScrollViewLayout() {
        settingListScrollView.addSubviews(settingListVStack)
        
        NSLayoutConstraint.activate([
            settingListScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingListScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingListScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingListScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setSettingListVStackLayout() {
        settingListVStack.addArrangedSubviews(
            goalSettingVStack,
            callTimeSettingVStack,
            alarmSettingVStack
        )
        
        NSLayoutConstraint.activate([
            settingListVStack.topAnchor.constraint(equalTo: settingListScrollView.topAnchor),
            settingListVStack.leadingAnchor.constraint(equalTo: settingListScrollView.leadingAnchor),
            settingListVStack.trailingAnchor.constraint(equalTo: settingListScrollView.trailingAnchor),
            settingListVStack.bottomAnchor.constraint(equalTo: settingListScrollView.bottomAnchor),
            settingListVStack.widthAnchor.constraint(equalTo: settingListScrollView.widthAnchor)
        ])
    }
    
    func setGoalSettingLayout() {
        goalSettingVStack.addArrangedSubviews(
            goalSettingTitleLabel,
            goalSettingBoxView,
            goalSettingDescriptionLabel
        )
        
        NSLayoutConstraint.activate([
            goalSettingVStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            goalSettingVStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goalSettingBoxView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            goalSettingBoxView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goalSettingDescriptionLabel.trailingAnchor.constraint(equalTo: goalSettingBoxView.trailingAnchor, constant: -16)
        ])
    }
    
    func setCallTimeSettingLayout() {
        callTimeSettingVStack.addArrangedSubviews(
            callTimeSettingTitleLabel,
            callTimeBoxView,
            callTimeSettingDescriptionLabel
        )
        
        NSLayoutConstraint.activate([
            callTimeSettingVStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            callTimeSettingVStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            callTimeBoxView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            callTimeBoxView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            callTimeSettingDescriptionLabel.trailingAnchor.constraint(equalTo: callTimeBoxView.trailingAnchor, constant: -16)
        ])
    }
    
    func setAlarmSettingLayout() {
        alarmSettingVStack.addArrangedSubviews(
            alarmSettingTitleLabel,
            alarmSettingBoxView,
            alarmSettingDescriptionLabel
        )
        
        NSLayoutConstraint.activate([
            alarmSettingVStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            alarmSettingVStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alarmSettingBoxView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            alarmSettingBoxView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alarmSettingDescriptionLabel.trailingAnchor.constraint(equalTo: alarmSettingBoxView.trailingAnchor, constant: -16)
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
