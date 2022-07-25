//
//  UserNotificationManager.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UserNotifications

final class UserNotificationManager {
    private let notificationCenter = UNUserNotificationCenter.current()
    private let contactStartDay = "20220701"
    private let notificationPeriod = 7 // 7일에 한번씩 연락한다고 했을 때
    private let lastContactDay = "20220710"

    // 유저가 연락커밋을 했을때, remove 해주고, 그다음에 다시 make해주면 될듯?
    // remove 하고 contactStartDay가 그날짜로 갱신되어야함
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("request 전부 삭제")
    }

    func makeNotificationContent() -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        // TODO: 30분마다 문구 바뀌어야함
        notificationContent.title = "연락할때가 되었음"
        notificationContent.body = "부모님이 기다리신다 얼른 연락하렴!"
        return notificationContent
    }

    // 현재 대기중인 noti 보여줌 (고반의 코드)
    func checkPendingNotificationRequest() {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            if notificationRequests.isEmpty {
                print("Pending request 없음")
            } else{
                for notification: UNNotificationRequest in notificationRequests {
                    print("----------requests info------------")
                    print(notification.identifier)
                    print(notification.content.title)
                    print(notification.content.body)
                    print(notification.trigger ?? "No trigger")
                    print("-----------------------------------")
                }
            }
        }
    }
}
