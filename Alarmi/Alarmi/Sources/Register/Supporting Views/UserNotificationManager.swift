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
    private let startTime = Date() // Model - CallTime - start
    private lazy var endTime = Calendar.current.date(byAdding: .minute, value: 60, to: startTime) // Model - CallTime - end
    private var identifier = ""

    private var identifierFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd a hh:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

    private var hourFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

    private var minuteFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "m"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }

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
                var time = Date()
                if type == 0 {
                    self.identifier = self.identifierFormatter.string(from: self.contactStartDate)
                    time = contactStartDate
                } else {
                    self.identifier = self.identifierFormatter.string(from: self.endTime ?? Date())
                    time = endTime ?? Date()
                }
                var requestDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: time)
                requestDateComponents.hour = Int(hourFormatter.string(from: time))
                requestDateComponents.minute = Int(minuteFormatter.string(from: time))
                let content = self.makeNotificationContent(type)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: requestDateComponents, repeats: false)
                let tempTrigger = UNTimeIntervalNotificationTrigger(timeInterval: self.notificationPeriod, repeats: false)
                let request = UNNotificationRequest(identifier: self.identifier, content: content, trigger: tempTrigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
