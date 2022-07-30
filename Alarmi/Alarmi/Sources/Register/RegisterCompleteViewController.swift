//
//  SettingCompleteViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit
import CoreData

protocol RegisterCompleteViewControllerDelegate: AnyObject {
    func finishRegister()
}

final class RegisterCompleteViewController: UIViewController {
    
    // MARK: View

    let encoder = JSONEncoder()
    
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
    
    private lazy var startButton: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "완료"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    weak var delegate: RegisterCompleteViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    // MARK: Method
    
    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
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
            descriptionStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            descriptionStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            startButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func buttonDidTap() {
        do {
            // fetchRequest를 통해 managedContext로부터 결과 배열을 가져오기
            try readCoreData()
        } catch {
            print("Could not save.")
        }
        delegate?.finishRegister()
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct SettingCompleteViewController_Preview: PreviewProvider {
    static var previews: some View {
        RegisterCompleteViewController()
            .toPreview()
            .ignoresSafeArea()
    }
}
#endif
