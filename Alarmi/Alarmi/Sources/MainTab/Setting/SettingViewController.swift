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
    
    private lazy var alarmSettingView: AlarmSettingView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(AlarmSettingView())
    
    private let alarmSettingDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setDynamicFont(.caption1)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.text = "알림이 온 이후에 전화를 기록하지 않으면,\n전화 시간 종료 전에 알림을 다시 보내드려요."
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

    func attribute() {
        view.backgroundColor = .systemGroupedBackground
        setNavigationBar()
    }

    func layout() {
        alarmSettingVStack.addArrangedSubviews(
            alarmSettingTitleLabel,
            alarmSettingView,
            alarmSettingDescriptionLabel
        )
        
        view.addSubviews(alarmSettingVStack)
        
        NSLayoutConstraint.activate([
            alarmSettingVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    func setNavigationBar() {
        title = "설정"
        navigationController?.navigationBar.prefersLargeTitles = false
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
