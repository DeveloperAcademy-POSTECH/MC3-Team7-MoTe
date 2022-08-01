//
//  TodayViewModel.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/28.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class TodayViewModel: ObservableObject {

    var viewWillAppear = PassthroughSubject<Void, Never>()
    var didCallButtonTapped = PassthroughSubject<Void, Never>()
    var didTapGoalTimeChangeButton = PassthroughSubject<Date, Never>()

    @Published var todayKoreaState: KoreaParentState = .canCall
    @Published var lastCall: TodayDDayDdipViewModel = .init()
    @Published var nextGoal: TodayDDayDdipViewModel = .init()
    @Published var todayDidCall: Bool = false
    @Published var goalTimeDate: Date = Date()

    private var cancellable = Set<AnyCancellable>()

    private var model: TodayModel!
    private var alarmManager = UserNotificationManager.shared

    init(_ model: TodayModel) {
        self.model = model
        setAlarm()
        viewWillAppear.sink { [weak self] _ in
            self?.todayKoreaState = Date().judgeKoreaState()
        }.store(in: &cancellable)

        model.goalTime
            .sink { [weak self] in
                let nextGoal = TodayDDayDdipViewModel.init($0)
                self?.nextGoal = nextGoal
                self?.goalTimeDate = $0.startDate.before(day: -$0.period + 1)
            }.store(in: &cancellable)
        model.callDateList
            .sink { [weak self] in
                guard let lastCall = $0.last.map(TodayDDayDdipViewModel.init) else { return }
                self?.lastCall = lastCall
            }.store(in: &cancellable)
        model.callDateList
            .compactMap { _ in model.callDateList.value.last }
            .filter { Calendar.current.isDateInToday($0.date) }
            .sink { [weak self] _ in
                self?.todayDidCall = true
            }.store(in: &cancellable)

        didTapGoalTimeChangeButton
            .sink {
                let currentGoalTimePeriod = model.goalTime.value.period
                let dayDistance: Int = Date().fullDistance(from: $0, resultIn: .day)!
                let addingValue: Int = dayDistance >= 0 ? -currentGoalTimePeriod + 1 : -currentGoalTimePeriod
                model.updateGoalTime(
                    .init(
                        startDate: Calendar.current.date(byAdding: .day, value: addingValue, to: $0)!,
                        period: currentGoalTimePeriod
                    ))
            }.store(in: &cancellable)

        didCallButtonTapped
            .filter { _ in model.callDateList.value.isEmpty }
            .sink { [weak self] _ in
                self?.todayDidCall = true
                model.addTodayDate(with: !(self?.nextGoal.isBefore ?? true))
                let currentGoalTime = model.goalTime.value
                model.updateGoalTime(
                    .init(startDate: Date(), period: currentGoalTime.period)
                )
            }.store(in: &cancellable)
        didCallButtonTapped
            .compactMap { _ in model.callDateList.value.last }
            .filter { date in !Calendar.current.isDateInToday(date.date) }
            .sink { [weak self] _ in
                self?.todayDidCall = true
                model.addTodayDate(with: !(self?.nextGoal.isBefore ?? true))
                let currentGoalTime = model.goalTime.value
                model.updateGoalTime(
                    .init(startDate: Date(), period: currentGoalTime.period)
                )
            }.store(in: &cancellable)
    }

    private func setAlarm() {

        model.callTime
            .sink { [weak self] time in
                guard let goalTime = self?.model.goalTime.value else { return }
                self?.alarmManager.requestAuthorization { [weak self] in
                    self?.alarmManager.sendUserNotification(
                        startTime: time.start,
                        endTime: time.end,
                        startDate: goalTime.startDate,
                        goalPeriod: goalTime.period)
                }
            }.store(in: &cancellable)

        model.goalTime
            .sink { [weak self] goalTime in
                guard let callTime = self?.model.callTime.value else { return }
                self?.alarmManager.requestAuthorization { [weak self] in
                    self?.alarmManager.sendUserNotification(
                        startTime: callTime.start,
                        endTime: callTime.end,
                        startDate: goalTime.startDate,
                        goalPeriod: goalTime.period)
                }
            }.store(in: &cancellable)

    }
    deinit {
        print("☠️☠️☠️☠️ \(String(describing: self)) ☠️☠️☠️☠️☠️")
    }
}
