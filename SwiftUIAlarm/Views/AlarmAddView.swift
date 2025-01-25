//
//  AlarmAddView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/19.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmAddView: View {
    @EnvironmentObject var alarmData: AlarmData
    @Environment(\.presentationMode) var presentationMode

    @State var date: Date = Date()
    @State var repeatDay: [RepeatDay] = []
    @State var label: String = "Alarm"

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
                NavigationLink(destination: AlarmRepeatView(repeatDay: $repeatDay)) {
                    Text("Repeat")
                }
                NavigationLink(destination: AlarmLabelView(label: $label)) {
                    Text("Label")
                }
            }
            .navigationTitle("Add Alarm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAlarm()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func saveAlarm() {
        let newAlarm = Alarm(date: date, label: label, repeatDay: repeatDay, isActive: true, isSnooze: false)
        alarmData.alarms.append(newAlarm)
        alarmData.saveAlarms()
    }
}
