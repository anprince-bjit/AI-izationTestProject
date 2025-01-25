//
//  Alarm.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

//
//  Alarm.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Foundation
import UserNotifications

struct Alarm: Identifiable, Codable {
    var id: UUID
    var date: Date
    var label: String
    var repeatDay: [RepeatDay]
    var isActive: Bool
    var isSnooze: Bool

    init(id: UUID = UUID(), date: Date = Date(), label: String = "Alarm", repeatDay: [RepeatDay] = [], isActive: Bool = true, isSnooze: Bool = false) {
        self.id = id
        self.date = date
        self.label = label
        self.repeatDay = repeatDay
        self.isActive = isActive
        self.isSnooze = isSnooze
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = label
        content.body = "Your alarm is going off!"
        content.sound = .default

        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        if !repeatDay.isEmpty {
            dateComponents.weekday = repeatDay.first?.rawValue
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: !repeatDay.isEmpty)

        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled: \(request.identifier) at \(dateComponents)")
            }
        }
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
}
