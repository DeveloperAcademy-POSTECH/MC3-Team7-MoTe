//
//  SettingCompleteViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class SettingCompleteViewController: UIViewController {
    
    // MARK: View
    
    private let descriptionStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let checkSymbol: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 100))
        let image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
        $0.image = image
        return $0
    }(UIImageView())
    
    private let primaryDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "모든 설정을 완료했어요."
        $0.setDynamicFont(.title3)
        return $0
    }(UILabel())
    
    private let secondaryDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "목표일이 되면 부모님께 전화드리고\n기록을 남겨보세요."
        $0.textAlignment = .center
        $0.setDynamicFont(.title3)
        return $0
    }(UILabel())
    
    private let startButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.titleAlignment = .center
        $0.configuration?.cornerStyle = .medium
        $0.configuration?.title = "시작"
        return $0
    }(UIButton(configuration: .filled()))
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        attribute()
        layout()
    }
    
    // MARK: Method
    
    private func attribute() {
        let action = UIAction { _ in
            // TODO: 메인 화면으로 이동
        }
        startButton.addAction(action, for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(descriptionStack, startButton)

        descriptionStack.addArrangedSubviews(
            checkSymbol,
            primaryDescriptionLabel,
            secondaryDescriptionLabel
        )

        NSLayoutConstraint.activate([
            descriptionStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionStack.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor
            ),
            descriptionStack.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor
            )
        ])

        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor
            ),
            startButton.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor
            ),
            startButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}

// MARK: - Preview

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
