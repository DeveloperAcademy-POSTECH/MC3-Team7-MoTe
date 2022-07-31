//
//  RecordViewModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class RecordViewModel: ObservableObject {
    typealias Weekdend = [Frequency]
    typealias WeekendList = [Weekdend]
    typealias FrequencyDataList = [Frequency]

    var cancelBag = Set<AnyCancellable>()

    // MARK: Input

    var viewDidLoad = PassthroughSubject<Void, Never>()

    // MARK: Output

    @Published var frequencyDateList: WeekendList = RecordViewModel.dummyFrequencyDataList
    @Published var goalCount: Int = 0
    @Published var goalCombo: Int = 0
    @Published var achievement: [Bool] = [false, true, false]

    init(_ model: RecordModel) {
        viewDidLoad.sink { [weak self] in
            let storedDateList = model.fetchCallDataList()
            self?.prepareFrequencyDataList(storedDateList)
        }
        .store(in: &cancelBag)
    }
}

extension RecordViewModel {

    // MARK: Business Logic

    private func prepareFrequencyDataList(_ dates: [CallDate]) {
        let ddipDates = createFrequencyDataList(with: dates)
        frequencyDateList = convertModel(ddipDates)
    }

    private func createFrequencyDataList(with dates: [CallDate]) -> FrequencyDataList {
        let todayIndex = (Constant.Record.numberOfColumns - 1) * 7 + DateManager.shared.todayWeekend().weekday! - 2 // 1 = 일요일
        var index: Int = 0

        return (0..<Constant.Record.numberOfColumns * 7).map { (ind) -> Frequency in
            let currentday: Int = todayIndex - ind
            let currentDate = DateManager.shared.todayBefore(currentday)!

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
    }

    private func convertModel(_ ddipDates: Weekdend) -> WeekendList {
        var dataList: WeekendList = []
        ddipDates.enumerated().forEach {
            if ($0.offset) % 7 == 0 {
                let weekend: Weekdend = Array(ddipDates[$0.offset..<$0.offset+7])
                if !weekend.isEmpty { dataList.append(weekend) }
            }
        }
        return dataList
    }
}

extension RecordViewModel {

    // MARK: 애니메이션이 이상하게 구동되기 때문에 주는 초기값
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
