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
    // TODO: 그리즐리 유저디폴트
    private let contactStartDate = Date() // Model - Goal - startDate
    private let notificationPeriod = 7 // Model - Goal - peroid
    private let notificationCycle = 100
    private let startTime = Date() // date형태이기 때문에 임시로 이렇게 생성
    private lazy var endTime = Calendar.current.date(byAdding: .minute, value: 60, to: startTime)

    private var identifierDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

    private var identifierTimeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

    func makeNotificationRequest() {
        // startdate + 7 되는날짜 계싼
        // +7 될때부터 100일동안 매일 알림 시작 (for)
        // 하루 2번 알림  (for)
        // start , end time-30min 기준으로 trigger 만들면 됨.
        var notificationRequestDate = Calendar.current.date(byAdding: .day, value: notificationPeriod, to: contactStartDate)
        for _ in 0..<notificationCycle {
            for _ in 0..<2 {
                var requestStartDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: notificationRequestDate ?? Date())
                requestStartDateComponents.hour = 14 // startTime의 hour추출해야함
                requestStartDateComponents.minute = 0 // startTime의 min 추출해야함
                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: requestStartDateComponents, repeats: false)
                let notificationContent = makeNotificationContent()
                // identifier 생성해서 넣어야함 -> 해당 날짜 + 시간으로 넣자
                let identifierDate = identifierDateFormatter.string(from: notificationRequestDate ?? Date())
                let request = UNNotificationRequest(identifier: identifierDate, content: notificationContent, trigger: notificationTrigger)
                self.notificationCenter.add(request) { error in
                    if let error = error {
                        print(error)
                    }
                }
            }
            notificationRequestDate = Calendar.current.date(byAdding: .day, value: 1, to: notificationRequestDate ?? Date())
        }
    }

    // 유저가 연락커밋을 했을때, remove 해주고, 그다음에 다시 make해주면 될듯?
    // remove 하고 contactStartDay가 그날짜로 갱신되어야함
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("request 전부 삭제")
    }

    func makeNotificationContent() -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
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
