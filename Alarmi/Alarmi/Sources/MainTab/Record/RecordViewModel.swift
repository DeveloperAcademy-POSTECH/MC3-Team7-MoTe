//
//  RecordViewModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class RecordViewModel: ObservableObject {
    @Published var frequencyDateList: [[Frequency]] = RecordViewModel.dummyFrequencyDataList
    @Published var goalCount: Int = 0
    @Published var goalCombo: Int = 0
    @Published var achievement: [Bool] = [false, true, false]

    func viewDidLoad() {
        fetchMoTeDate()
    }

    // MARK: Business Logic

    private func fetchMoTeDate() {
        let dates = TimeCalculationManager.shared.testDummyDates()
        let todayIndex = (Constant.Record.numberOfColumns - 1) * 7 + TimeCalculationManager.shared.todayWeekend().weekday! - 2 // 1 = 일요일
        var index: Int = 0

        let ddipDates = (0..<Constant.Record.numberOfColumns * 7).map { (ind) -> Frequency in
            let currentday: Int = todayIndex - ind
            let currentDate = TimeCalculationManager.shared.todayBefore(currentday)!

            if ind > todayIndex {
                return Frequency(type: .future, date: currentDate)
            } else {
                guard index != dates.count else { return Frequency(type: .none, date: currentDate) }
                if Calendar.current.compare(currentDate, to: dates[index], toGranularity: .day) == .orderedSame {
                    index += 1
                    return Frequency(type: .did, date: dates[index-1])
                } else {
                    return Frequency(type: .none, date: currentDate)
                }
            }
        }

        frequencyDateList = convertModel(ddipDates)
    }

    private func convertModel(_ ddipDates: [Frequency]) -> [[Frequency]] {
        var models: [[Frequency]] = []
        ddipDates.enumerated().forEach {
            if ($0.offset) % 7 == 0 {
                let array: [Frequency] = Array(ddipDates[$0.offset..<$0.offset+7])
                print(array.count)
                if !array.isEmpty { models.append(array) }
            }
        }
        return models
    }
}

extension RecordViewModel {

    static var dummyFrequencyDataList: [[Frequency]] {
        .init((0..<Constant.Record.numberOfColumns).map { _ in
            [
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date()),
                Frequency(type: .future, date: Date())
            ]
        })
    }
}
