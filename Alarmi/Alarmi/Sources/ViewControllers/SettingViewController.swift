//
//  SettingViewController.swift
//  Alarmi
//
//  Created by 민채호 on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class SettingViewController: UIViewController {
    
    // MARK: View
    
    private let settingTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentOffset = .init(x: 0, y: -16)
        $0.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    private let eraseRecordAlert: UIAlertController = {
        let eraseAction = UIAlertAction(title: "초기화", style: .destructive) { _ in
            // TODO: 기록 초기화
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        $0.addAction(eraseAction)
        $0.addAction(cancelAction)
        return $0
    }(UIAlertController(
        title: "기록을 정말 초기화하시겠어요?",
        message: "모든 기록이 삭제되며, 되돌릴 수 없습니다.",
        preferredStyle: .alert
    ))
    
    // MARK: Property
    
    private let settingList = ["나라 변경", "전화 시간 변경", "목표 변경", "알림 설정", "기록 초기화"]
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
        attribute()
        layout()
    }
    
    // MARK: Method
    
    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
    }
    
    private func layout() {
        view.addSubviews(settingTableView)
        
        NSLayoutConstraint.activate([
            settingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingTableView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "설정"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Protocol

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel!.text = settingList[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        if indexPath.row < 4 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel!.textColor = .systemRed
        }
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingTableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            // TODO: 각 설정 화면으로 내비게이션
        case 4:
            self.present(eraseRecordAlert, animated: true)
        default:
            break
        }
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
