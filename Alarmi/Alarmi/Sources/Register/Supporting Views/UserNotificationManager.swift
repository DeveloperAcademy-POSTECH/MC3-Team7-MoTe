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
        let notificationInterval = calculateTimeInterval(startTime, endTime) // int 7
        var requestDateComponents = calculateDate(startDate, goalPeriod) // 일단 이걸 7일뒤로 설정해줌
        notificationCenter.getNotificationSettings { [weak self] (settings) in
            guard settings.authorizationStatus == UNAuthorizationStatus.authorized else { return }
            // 6번 반복
            for cycle in 0..<100 {
                if cycle == 0 {
                    var notificationTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                    for index in 1..<7 {
                        requestDateComponents.hour = notificationTimeComponents.hour
                        requestDateComponents.minute = notificationTimeComponents.minute
                        let content = self?.makeNotificationContent(index) // enum에 있는거 등록
                        let trigger = UNCalendarNotificationTrigger(dateMatching: requestDateComponents, repeats: false)
                        let identifier = self?.identifierFormatter(requestDateComponents) ?? ""
                        let request = UNNotificationRequest(identifier: identifier, content: content ?? UNMutableNotificationContent(), trigger: trigger)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        // request date component 에서 interval(분) 더해줘야함
                        notificationTimeComponents = self!.calculateTime(startTime, notificationInterval, index)
                    }
                } else {
                    // 시간; 두번째 사이클 부터는 day+1씩되고 알림은 한번씩만, start time에!
                    // 날짜; requestdatecomponents쓰면돼
                    let content = self?.makeNotificationContent(1)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: requestDateComponents, repeats: false)
                    let identifier = self?.identifierFormatter(requestDateComponents) ?? ""
                    let request = UNNotificationRequest(identifier: identifier, content: content ?? UNMutableNotificationContent(), trigger: trigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
                // requestDateComponents +1day 해줘야함
                let temp = Calendar.current.date(from: requestDateComponents)
                requestDateComponents = self?.calculateDate(temp ?? Date(), 1) ?? DateComponents()
            }
        }
    }

    // TODO: 연락 커밋을 눌렀을때 해당 메서드를 불러서 request 모두 삭제
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("request 전부 삭제")
    }

    // TODO: 연락 문구 정해야함
    func makeNotificationContent(_ index: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        let indexName = Content(rawValue: index)
        notificationContent.title = indexName?.title ?? ""
        notificationContent.body = indexName?.body ?? ""
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

    // interval을 더해주는 함수
    private func calculateTime(_ startTime: Date, _ interval: Int, _ index: Int) -> DateComponents {
        let notificationTime = Date(timeInterval: Double(interval * index), since: startTime)
        let dateToDatecomponent = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        return dateToDatecomponent
    }

    // 7일뒤를 계산해주는 함수
    private func calculateDate(_ startDate: Date, _ goalperiod: Int) -> DateComponents {
        let dateInterval = goalperiod * 24 * 60 * 60
        let notificationDate = Date(timeInterval: Double(dateInterval), since: startDate)
        let requestDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        return requestDateComponents
    }
}
