//
//  AlarmListView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var alarmData: AlarmData
    @State private var showingAddAlarm = false

    var body: some View {
        NavigationView {
            List {
                ForEach(self.alarmData.alarms) { alarm in
                    NavigationLink(destination: AlarmDetailView(alarm: alarm, isPresentedModally: false)) {
                        AlarmRow(alarm: alarm)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Alarms")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingAddAlarm = true }) {
                        Label("Add Alarm", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddAlarm) {
                AlarmDetailView(alarm: Alarm(date: Date(), label: "", repeatDay: [.sunday], isActive: true, isSnooze: false), isPresentedModally: true)
                    .environmentObject(alarmData)
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        alarmData.alarms.remove(atOffsets: offsets)
        alarmData.saveAlarms()
    }
}

struct AlarmRow: View {
    var alarm: Alarm

    var body: some View {
        VStack(alignment: .leading) {
            Text(alarm.label)
                .font(.headline)
            Text(alarm.date, style: .time)
                .font(.subheadline)
        }
    }
}
