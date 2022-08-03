//
//  RegisterCallTimeViewModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/29.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class RegisterViewModel: ObservableObject {

    var dayStepper = PassthroughSubject<Int, Never>()
//    var startDate = PassthroughSubject<Date, Never>()
    var goalNextButtonDidTap = PassthroughSubject<Void, Never>()
    var callTimeNextButtonDidTap = PassthroughSubject<Void, Never>()
    var startTimeDate = PassthroughSubject<Date, Never>()
    var endTimeDate = PassthroughSubject<Date, Never>()
    var startButtonDidTap = PassthroughSubject<Void, Never>()

    @Published var callPeriod: Int = 7
    @Published var startDate: Date = Date()

    private let userNotificationManager = UserNotificationManager.shared
    private var cancellable = Set<AnyCancellable>()

    weak var registerPlanViewControllerDelegate: RegisterPlanViewControllerDelegate?
    weak var registerCallTimeViewControllerDelegate: RegisterCallTimeViewControllerDelegate?
    weak var registerCompleteViewControllerDelegate: RegisterCompleteViewControllerDelegate?

    init(model: RegisterModel) {

        dayStepper
            .sink { [weak self] in
                model.updateCallPeriod($0)
                self?.callPeriod = $0
            }.store(in: &cancellable)

        $startDate
            .sink {
                model.updateGoalDate($0.after(day: model.callPeriod.value))
            }.store(in: &cancellable)

        startTimeDate
            .sink {
                let callTime = model.callTime.value
                model.updateCallTime(.init(start: $0, end: callTime.end))
            }.store(in: &cancellable)

        endTimeDate
            .sink {
                let callTime = model.callTime.value
                model.updateCallTime(.init(start: callTime.start, end: $0))
            }.store(in: &cancellable)

        goalNextButtonDidTap
            .sink { [weak self] in
                model.updateCallPeriod(self?.callPeriod ?? 7)

                let startDate = self?.startDate ?? Date()
                model.updateGoalDate(startDate.after(day: model.callPeriod.value))
                self?.registerPlanViewControllerDelegate?.gotoRegisterCallTimeViewController()
                print("목표 주기 업데이트 완료", self?.callPeriod ?? 7)
                print("목표일 업데이트 완료", model.goalDate.value)
            }.store(in: &cancellable)

        callTimeNextButtonDidTap
            .sink { [weak self] in
                let callTime = model.callTime.value
                model.updateCallTime(.init(start: callTime.start, end: callTime.end))
                self?.registerCallTimeViewControllerDelegate?.gotoRegisterCompleteViewController()
                print("전화 시간 업데이트 완료 ", model.callTime.value)
            }.store(in: &cancellable)

        startButtonDidTap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.userNotificationManager.requestAuthorization { [weak self] in
                    model.updateAlarm(.init(isAlarm: true, isAlarmAgain: true))

                    let startDate = model.goalDate.value.before(day: model.callPeriod.value)
                    self?.userNotificationManager.sendUserNotification(
                        startTime: model.callTime.value.start,
                        endTime: model.callTime.value.end,
                        startDate: startDate,
                        goalPeriod: model.callPeriod.value
                    )
                    DispatchQueue.main.async {
                        self?.registerCompleteViewControllerDelegate?.finishRegister()
                    }
                }
            }.store(in: &cancellable)

    }

}
