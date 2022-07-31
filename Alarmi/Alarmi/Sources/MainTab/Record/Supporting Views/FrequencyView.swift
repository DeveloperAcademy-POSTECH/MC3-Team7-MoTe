//
//  FrequencyView.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import SwiftUI

struct FrequencyView: View {
    private let offset: CGFloat = 16
    private let numberOfColumns: Int = Constant.Record.numberOfColumns

    var frequencyDataList: [[Frequency]]

    var body: some View {
        HStack(alignment: .bottom, spacing: 3) {
            VStack(alignment: .center, spacing: 1) {
                ForEach(self.weekends, id: \.self) {
                    Text($0)
                        .frame(width: self.calculateBoxWidth(),
                               height: self.calculateBoxWidth(),
                               alignment: .center)
                }
            }

            VStack(spacing: 1) {
                HStack(alignment: .center, spacing: 1) {
                    ForEach(frequencyDataList, id: \.self) { weekend in
                        let date = weekend.filter { $0.date.contains1stDayOfMonth() }
                        if !date.isEmpty {
                            Text(date.first!.date.getMonthString())
                                .fixedSize()
                        } else {
                            Text("")
                                .frame(width: self.calculateBoxWidth(),
                                       height: self.calculateBoxWidth(),
                                       alignment: .center)
                        }

                    }
                }
                HStack(alignment: .center, spacing: 1) {
                    ForEach(frequencyDataList, id: \.self) { weekend in
                        VStack(alignment: .center, spacing: 1) {
                            ForEach(weekend, id: \.self) { date in
                                switch date.type {
                                case .none:
                                    Color(UIColor.systemGray5)
                                case .future:
                                    Color(UIColor.systemGray6)
                                case .did:
                                    Color.indigo
                                }
                            }
                            .frame(width: self.calculateBoxWidth(),
                                   height: self.calculateBoxWidth(),
                                   alignment: .center)
                            .cornerRadius(4)
                        }
                    }
                }
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }

    private func calculateBoxWidth() -> CGFloat {
        let width = (UIScreen.main.bounds.width - 32 - offset * 2) / CGFloat(self.numberOfColumns + 2)
        return width
    }
}

extension FrequencyView {
    var weekends: [String] {
        ["월", "화", "수", "목", "금", "토", "일"]
    }
}

struct FrequencyView_Previews: PreviewProvider {
    static var dummyFrequencyDataList: [[Frequency]] {
        .init((0..<Constant.Record.numberOfColumns).map { _ in
            [
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date()),
                Frequency(type: .none, date: Date())
            ]
        })
    }
    static var previews: some View {
        FrequencyView(frequencyDataList: FrequencyView_Previews.dummyFrequencyDataList)
            .frame(width: 320, height: 150, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
