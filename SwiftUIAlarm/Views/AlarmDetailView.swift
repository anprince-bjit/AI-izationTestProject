//
//  AlarmDetailView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmDetailView: View {
    @EnvironmentObject var alarmData: AlarmData
    @Environment(\.presentationMode) var presentationMode
    @State var alarm: Alarm
    @State private var showingRepeatView = false
    var isPresentedModally: Bool

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Time", selection: $alarm.date, displayedComponents: .hourAndMinute)

                TextField("Label", text: $alarm.label)

                Button(action: {
                    showingRepeatView = true
                }) {
                    HStack {
                        Text("Repeat")
                        Spacer()
                        Text(repeatDaysDescription())
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $showingRepeatView) {
                    AlarmRepeatView(repeatDay: $alarm.repeatDay)
                }

                Toggle(isOn: $alarm.isActive) {
                    Text("Active")
                }

                Toggle(isOn: $alarm.isSnooze) {
                    Text("Snooze")
                }
            }
            .navigationTitle("Edit Alarm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAlarm()
                        if isPresentedModally {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }

    private func repeatDaysDescription() -> String {
        if alarm.repeatDay.isEmpty {
            return "Never"
        } else {
            return alarm.repeatDay.map { $0.shortName }.joined(separator: ", ")
        }
    }

    private func saveAlarm() {
        if let index = alarmData.alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarmData.alarms[index].cancelNotification()
            alarmData.alarms[index] = alarm
        } else {
            alarmData.alarms.append(alarm)
        }
        alarm.scheduleNotification()
        alarmData.saveAlarms()
    }
}

struct AlarmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlarmDetailView(alarm: Alarm(date: Date(), label: "Sample Alarm", repeatDay: [], isActive: true, isSnooze: false), isPresentedModally: false)
                .environmentObject(AlarmData())
        }
    }
}
