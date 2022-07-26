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
    private var notificationPeriod = 7.0 // Model - Goal - peroid
    private let notificationCycle = 100
    private let startTime = Date() // date형태이기 때문에 임시로 이렇게 생성
    private var identifier = ""
    private lazy var endTime = Calendar.current.date(byAdding: .minute, value: 60, to: startTime)

    private var identifierFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd a hh:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

    // 권한요청 확인
    func generateUserNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print(error)
            } else {
                if granted {
                    self.sendUserNotification()
                }
            }
        }
    }

    func sendUserNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { [self] (settings) in
            guard settings.authorizationStatus == UNAuthorizationStatus.authorized else { return }
            for type in 0..<2 {
                if type == 0 {
                    self.identifier = self.identifierFormatter.string(from: self.contactStartDate)
                } else {
                    self.identifier = self.identifierFormatter.string(from: self.endTime ?? Date())
                }
                let content = self.makeNotificationContent(type)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.notificationPeriod, repeats: false)
                let request = UNNotificationRequest(identifier: self.identifier, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                self.notificationPeriod += 10.0
            }
        }
    }

    // TODO: 연락 커밋을 눌렀을대 해당 메서드를 불러서 request 모두 삭제
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("request 전부 삭제")
    }

    // TODO: 연락 문구 정해야함 -> 일단 두개
    func makeNotificationContent(_ type: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = ""
        notificationContent.body = ""
        switch type {
        case 0:
            notificationContent.title = "연락할시간이다!"
            notificationContent.body = "연락할 시간이다!"
        default:
            notificationContent.title = "연락할 시간이 끝나가요!"
            notificationContent.body = "연락할 시간이 끝나가요!"
        }
        return notificationContent
    }

    // 현재 대기중인 noti 보여줌 (고반의 코드)
    func checkPendingNotificationRequest() {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            if notificationRequests.isEmpty {
                print("Pending request 없음")
            } else {
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
