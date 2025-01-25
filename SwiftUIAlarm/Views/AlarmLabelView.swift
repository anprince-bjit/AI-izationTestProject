//
//  AlarmLabelView.swift
//  SwiftUIAlarm
//
//  Created by Tae joong Yoon on 2019/06/20.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import SwiftUI

struct AlarmLabelView: View {
    @Binding var label: String

    var body: some View {
        Form {
            TextField("Label", text: $label)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .navigationBarTitle(Text("Label"), displayMode: .inline)
    }
}

struct AlarmLabelView_Previews: PreviewProvider {
    @State static var label = "Sample Label"

    static var previews: some View {
        AlarmLabelView(label: $label)
    }
}
