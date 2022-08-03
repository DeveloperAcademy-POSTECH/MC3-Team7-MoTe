//
//  TodayViewModel.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class TodayViewModel: ObservableObject {

    var viewDidLoad = PassthroughSubject<Void, Never>()
    var didCallButtonTapped = PassthroughSubject<Void, Never>()
    var didTapGoalTimeChangeButton = PassthroughSubject<Date, Never>()

    @Published var todayKoreaState: KoreaParentState = .canCallLight
    @Published var lastCallDDay: TodayDDayDdipViewModel = .init()
    @Published var goaldDay: TodayDDayDdipViewModel = .init()
    @Published var todayDidCall: Bool = false
    @Published var callDelayGoalTimeDate: Date = Date()
    @Published var minimumDatePickerDate: Date = Date()

    private var cancellable = Set<AnyCancellable>()

    private var model: TodayModel!
    private var alarmManager = UserNotificationManager.shared

    init(_ model: TodayModel) {
        self.model = model

        viewDidLoad.sink { [weak self] _ in
            self?.todayKoreaState = Date().judgeKoreaState()
        }.store(in: &cancellable)

        /*

         오늘 탭읩 d-day같은 경우, 오늘 날짜 - 목표일 인데 목표일 계산은 startDate + periodTime이다.

         미룰 때  goalTime의 startDate를 바꾼다.

         미룰 때 제한 날짜 같은 경우 오늘을 제외한 다른 날도 포함시킨다.

         */

        // ✅ 목표 D-Day
        TimerManager.shared.timer
            .sink { [weak self] _ in
                self?.goaldDay = TodayDDayDdipViewModel(model.goalDate.value)
            }.store(in: &cancellable)

        // ✅ 목표 D-Day
        model.goalDate
            .sink { [weak self] goalDate in
                print(goalDate)
                self?.goaldDay = TodayDDayDdipViewModel(goalDate)
            }.store(in: &cancellable)

        // ✅ callDelayGoalTimeDate 미루기에서 알림 주는 날짜 초기값
        model.goalDate
            .sink { [weak self] goalDate in
                self?.callDelayGoalTimeDate = goalDate
            }.store(in: &cancellable)

        // 마지막 전화 D-Day 문구 - 리스트에 값이 없을 경우
        model.callDateList
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                self?.lastCallDDay = TodayDDayDdipViewModel()
            }.store(in: &cancellable)
        
        // 마지막 전화 D-Day 문구 - 리스트에 값이 있을 경우
        model.callDateList
            .compactMap { list in
                list.last
            }.sink { [weak self] lastCallDate in
                self?.lastCallDDay = TodayDDayDdipViewModel(lastCallDate)
            }.store(in: &cancellable)

        // ✅ 오늘 전화했는지 안했는지 체크하기,  "전화했어요" 버튼을 위하여
        model.callDateList
            .compactMap { _ in model.callDateList.value.last }
            .filter { Calendar.current.isDateInToday($0.date) }
            .sink { [weak self] _ in
                self?.todayDidCall = true
            }.store(in: &cancellable)

        // ✅ 미루기 버튼
        didTapGoalTimeChangeButton
            .sink { selectedDate in
                model.updateGoalDate(selectedDate)
            }.store(in: &cancellable)

        // ✅ 전화했어요 버튼 누르기
        didCallButtonTapped
            .sink { [weak self] _ in
                self?.todayDidCall = true
                let isSuccess: Bool = (self?.goaldDay.dday.contains("+") ?? false ) ? false : true
                model.addTodayDate(with: isSuccess)
                model.updateGoalDate(Date().after(day: model.callPeriod.value))
            }.store(in: &cancellable)

        // ✅ 전화 가능 시간이 바뀌면 알림 재설정하기
        model.callTime
            .sink { [weak self] callTime in
                let period = self?.model.callPeriod.value ?? 7
                let startDate = self?.model.goalDate.value.before(day: period) ?? Date()
                self?.alarmManager.requestAuthorization { [weak self] in
                    self?.alarmManager.sendUserNotification(
                        startTime: callTime.start,
                        endTime: callTime.end,
                        startDate: startDate,
                        goalPeriod: period)
                }
            }.store(in: &cancellable)

        // ✅ 목표일이 바뀌면 알림 재설정하기
        model.goalDate
            .sink { [weak self] goalDate in
                let period = self?.model.callPeriod.value ?? 7
                let startDate = self?.model.goalDate.value.before(day: period) ?? Date()
                guard let callTime = self?.model.callTime.value else { return }
                self?.alarmManager.removeAllPendingRequest()
                self?.alarmManager.requestAuthorization { [weak self] in
                    self?.alarmManager.sendUserNotification(
                        startTime: callTime.start,
                        endTime: callTime.end,
                        startDate: startDate,
                        goalPeriod: period)
                }
            }.store(in: &cancellable)

    }

    deinit {
        print("☠️☠️☠️☠️ \(String(describing: self)) ☠️☠️☠️☠️☠️")
    }
}
