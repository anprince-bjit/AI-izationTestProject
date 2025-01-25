//
//  AlarmView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmView: View {
    @EnvironmentObject var alarmData: AlarmData
    var alarm: Alarm

    var body: some View {
        VStack {
            Text(alarm.label)
                .font(.largeTitle)

            Text(alarm.date, style: .time)
                .font(.title)

            if !alarm.repeatDay.isEmpty {
                Text("Repeats on: \(repeatDaysDescription())")
                    .font(.subheadline)
            }

            Toggle(isOn: .constant(alarm.isActive)) {
                Text("Active")
            }

            Toggle(isOn: .constant(alarm.isSnooze)) {
                Text("Snooze")
            }
        }
        .padding()
    }

    private func repeatDaysDescription() -> String {
        if alarm.repeatDay.isEmpty {
            return "Never"
        } else {
            return alarm.repeatDay.map { $0.shortName }.joined(separator: ", ")
        }
    }
}
