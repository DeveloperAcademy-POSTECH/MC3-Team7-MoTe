//
//  UserNotificationManager.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import UserNotifications
import UniformTypeIdentifiers

final class UserNotificationManager {
    private let notificationCenter = UNUserNotificationCenter.current()

    enum Content: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6

        var title: String {
            switch self {
            case .one:
                return "원"
            case .two:
                return "투"
            case .three:
                return "쓰리"
            case .four:
                return "포"
            case .five:
                return "파이브"
            case .six:
                return "식스"
            }
        }
        var body: String {
            switch self {
            case .one:
                return "바디원"
            case .two:
                return "바디투"
            case .three:
                return "바디쓰리"
            case .four:
                return "바디포"
            case .five:
                return "바디파이브"
            case .six:
                return "바디식스"
            }
        }
    }

    init() {
        requestAuthorization()
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            guard let _ = error, !granted else {
                // TODO: 에러처리
                return
            }
            // TODO: 아무것도 하지 않는다.
        }
    }

    func sendUserNotification(startTime: Date, endTime: Date, startDate: Date, goalPeriod: Int) {
        // 시간설정하는거 여기다가 다 적기 (trigger에 넣을 시간)

        notificationCenter.getNotificationSettings { [weak self] (settings) in
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

    // TODO: 연락 커밋을 눌렀을때 해당 메서드를 불러서 request 모두 삭제
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("request 전부 삭제")
    }

    // MARK: 알고리즘

    private func calculateTimeInterval(_ startTime: Date, _ endTime: Date, _ goalPeriod: Int) {
//        let timeGap: Double = endTime.timeIntervalSince(endTime) / 60
        let interval = Calendar.current.dateComponents([.minute], from: startTime, to: endTime) / 6  // 전화가능시간 /6 해서 interval 설정
8
    }


//    // TODO: 연락 문구 정해야함 -> 일단 두개
//    func makeNotificationContent(_ type: Int) -> UNMutableNotificationContent {
//        let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = ""
//        notificationContent.body = ""
//        switch type {
//        case 0:
//            notificationContent.title = "연락할시간이다!"
//            notificationContent.body = "연락할 시간이다!"
//        default:
//            notificationContent.title = "연락할 시간이 끝나가요!"
//            notificationContent.body = "연락할 시간이 끝나가요!"
//        }
//        return notificationContent
//    }

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

    // MARK: 알고리즘

    private func identifierFormatter(_ dateComponents: DateComponents) -> String {
        let dateComponentsToDate = Calendar.current.date(from: dateComponents) ?? Date()
        var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd a hh:mm"
            dateFormatter.timeZone = .init(identifier: "Asia/Seoul")
            return dateFormatter
        }
        let identifier = dateFormatter.string(from: dateComponentsToDate)
        return identifier
    }

    // interval을 구해주는 함수
    private func calculateTimeInterval(_ startTime: Date, _ endTime: Date) -> Int {
        let timeGap = Calendar.current.dateComponents([.minute], from: startTime, to: endTime)
        let interval = Int(timeGap.minute ?? 0) / 6 // 전화가능시간 /6 해서 interval 설정
        return interval
    }
}
