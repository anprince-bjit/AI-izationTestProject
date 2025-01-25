//
//  AlarmRepeatView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/20.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmRepeatView: View {
    @Binding var repeatDay: [RepeatDay]

    var body: some View {
        List {
            ForEach(RepeatDay.allCases) { day in
                AlarmRepeatCellView(repeatDay: self.$repeatDay, index: day.rawValue)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Repeat"), displayMode: .inline)
    }
}
