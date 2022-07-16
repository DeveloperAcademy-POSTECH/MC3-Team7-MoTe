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

// MARK: Protocol

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        if indexPath.row < 4 {
            cell.textLabel!.text = settingList[indexPath.row]
            cell.textLabel!.numberOfLines = 0
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel!.text = settingList[indexPath.row]
            cell.textLabel!.textColor = .systemRed
        }
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingTableView.deselectRow(at: indexPath, animated: true)
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
