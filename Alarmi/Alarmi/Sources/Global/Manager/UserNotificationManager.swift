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
    static let shared = UserNotificationManager()
    private init() {}
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
                return "부모님께 전화해주세요~"
            case .two:
                return "부모님이 기다리고 있어요."
            case .three:
                return "전화를 아직도 안 한다고..?"
            case .four:
                return "넌 항상 그런식이야."
            case .five:
                return "너 미쳤어???"
            case .six:
                return "넌 불효자다. 자식의 자격이 없어요."
            }
        }
        var body: String {
            switch self {
            case .one:
                return "오늘은 전화하는 날입니다. 카카오톡을 키고 한국에 계신 부모님께 전화를 드려보세요."
            case .two:
                return "부모님이 목이 빠지기 일보 직전이에요."
            case .three:
                return "손가락이 다쳤니…? 부모님은 마음이 다쳐가요"
            case .four:
                return "라는 말이 듣기 싫으면 전화하세요."
            case .five:
                return "그러다 호적 파여요."
            case .six:
                return "아~~~~~~~~~~~~~직두 전화를 안하셨다구요? 마지막이에요. 당장 해주세요."
            }
        }
    }

    func requestAuthorization(_ completion: @escaping () -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (_, error) in
            if let _ = error {

            } else {
                completion()
            }
        }
    }

    func sendUserNotification(startTime: Date, endTime: Date, startDate: Date, goalPeriod: Int) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print(error)
            } else {
                if granted {
                    for index in 1..<7 {
                        let content = self.makeNotificationContent(index)
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(56+index), repeats: false)
                        let request = UNNotificationRequest(identifier: "\(index)_notification", content: content, trigger: trigger)
                        self.notificationCenter.add(request, withCompletionHandler: nil)
                    }
                } else {
                    print("Not Granted")
                }
            }
        }
    }

//    func sendUserNotification(startTime: Date, endTime: Date, startDate: Date, goalPeriod: Int) {
//        let notificationInterval = calculateTimeInterval(startTime, endTime)
//        var requestDateComponents = calculateDate(startDate, goalPeriod)
//        notificationCenter.getNotificationSettings { [weak self] (settings) in
//            guard settings.authorizationStatus == UNAuthorizationStatus.authorized else { return }
//            for cycle in 0..<100 {
//                if cycle == 0 {
//                    var notificationTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
//                    for index in 1..<7 {
//                        requestDateComponents.hour = notificationTimeComponents.hour
//                        requestDateComponents.minute = notificationTimeComponents.minute
//
//                        guard let request = self?.makeNotificationRequest(index, requestDateComponents) else { return }
//
//                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//                        notificationTimeComponents = self?.calculateTime(startTime, notificationInterval, index) ?? DateComponents()
//                    }
//                } else {
//                    guard let request = self? .makeNotificationRequest(1, requestDateComponents) else { return }
//                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//                }
//                requestDateComponents = self?.calculateDate(startDate, 1) ?? DateComponents()
//            }
//        }
//    }

    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
    }

    func getAuthorizationStatus(_ completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            let authorized = settings.authorizationStatus == .authorized
            completion(authorized)
        }
    }

    private func makeNotificationContent(_ index: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        let indexName = Content(rawValue: index)
        notificationContent.title = indexName?.title ?? ""
        notificationContent.body = indexName?.body ?? ""
        return notificationContent
    }

    private func makeNotificationRequest(_ index: Int, _ requestDate: DateComponents) -> UNNotificationRequest {
        let content = self.makeNotificationContent(index)
        let trigger = UNCalendarNotificationTrigger(dateMatching: requestDate, repeats: false)
        let identifier = self.identifierFormatter(requestDate)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        return request
    }

    private func checkPendingNotificationRequest() {
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

    private func calculateTimeInterval(_ startTime: Date, _ endTime: Date) -> Int {
        let timeGap = Calendar.current.dateComponents([.minute], from: startTime, to: endTime)
        let interval = Int(timeGap.minute ?? 0) / 6 // 전화가능시간 /6 해서 interval 설정
        return interval
    }

    private func calculateTime(_ startTime: Date, _ interval: Int, _ index: Int) -> DateComponents {
        let notificationTime = Date(timeInterval: Double(interval * index), since: startTime)
        let dateToDatecomponent = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        return dateToDatecomponent
    }

    private func calculateDate(_ startDate: Date, _ goalperiod: Int) -> DateComponents {
        let dateInterval = goalperiod * 24 * 60 * 60
        let notificationDate = Date(timeInterval: Double(dateInterval), since: startDate)
        let requestDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        return requestDateComponents
    }
}
