//
//  AlarmData.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/14.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Foundation
import SwiftUI

class AlarmData: ObservableObject {
    @Published var alarms: [Alarm] = [] {
        didSet {
            saveAlarms()
        }
    }

    init() {
        loadAlarms()
    }

    func loadAlarms() {
        // Load alarms from UserDefaults or other persistent storage
        if let data = UserDefaults.standard.data(forKey: "alarms") {
            do {
                let decodedAlarms = try JSONDecoder().decode([Alarm].self, from: data)
                self.alarms = decodedAlarms
            } catch {
                print("Failed to decode alarms: \(error.localizedDescription)")
            }
        }
    }

    func saveAlarms() {
        // Save alarms to UserDefaults or other persistent storage
        do {
            let encodedAlarms = try JSONEncoder().encode(alarms)
            UserDefaults.standard.set(encodedAlarms, forKey: "alarms")
        } catch {
            print("Failed to encode alarms: \(error.localizedDescription)")
        }
    }
}
