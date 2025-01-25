//
//  AlarmRepeatCellView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/20.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmRepeatCellView: View {
    @Binding var repeatDay: [RepeatDay]
    var index: Int

    var isContained: Bool {
        repeatDay.contains(RepeatDay(rawValue: index)!)
    }

    var body: some View {
        HStack {
            Text("Every \(RepeatDay(rawValue: index)!.fullName)")
            Spacer()
            if isContained {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            let day = RepeatDay(rawValue: index)!
            if let dayIndex = repeatDay.firstIndex(of: day) {
                repeatDay.remove(at: dayIndex)
            } else {
                repeatDay.append(day)
            }
        }
    }
}
