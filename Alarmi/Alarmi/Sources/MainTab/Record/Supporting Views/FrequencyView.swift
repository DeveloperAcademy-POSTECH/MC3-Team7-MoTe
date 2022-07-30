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
        HStack(alignment: .center, spacing: 3) {
            VStack(alignment: .center, spacing: 1) {
                ForEach(self.weekends, id: \.self) {
                    Text($0)
                        .frame(width: self.calculateBoxWidth(),
                               height: self.calculateBoxWidth(),
                               alignment: .center)
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)

            HStack(alignment: .center, spacing: 1) {
                ForEach(frequencyDataList, id: \.self) { weekend in
                    VStack(alignment: .center, spacing: 1) {
                        ForEach(weekend, id: \.self) { date in
                            switch date.type {
                            case .none:
                                Color(UIColor.systemGray5)
                            case .future:
                                Color.clear
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
    static var previews: some View {
        FrequencyView(frequencyDataList: [[]])
            .frame(width: 320, height: 137, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
