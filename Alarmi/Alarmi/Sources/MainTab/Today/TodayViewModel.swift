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

    init(_ model: TodayModel) {
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
            .compactMap { _ in model.callDateList.value.last }
            .filter { date in !Calendar.current.isDateInToday(date.date) }
            .sink { [weak self] _ in
                self?.todayDidCall = true

                model.addTodayDate(with: !(self?.nextGoal.isPassed ?? true))
                let currentGoalTime = model.goalTime.value
                model.updateGoalTime(
                    .init(startDate: Date(), period: currentGoalTime.period)
                )
            }.store(in: &cancellable)
    }

    deinit {
        print("☠️☠️☠️☠️ \(String(describing: self)) ☠️☠️☠️☠️☠️")
    }
}
