//
//  JourneyEditor.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/28/24.
//

import SwiftUI

struct JourneyEditor: View {
    @Bindable var journey: Journey
    
    var body: some View {
        List {
            HStack {
                Text("Title")
                Spacer()
                TextField("Title", text: $journey.title)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Motivation")
                Spacer()
                TextField("Motivation", text: $journey.motivation)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            VStack {
                Text("Schedule")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                DaysPicker(selectedDays: $journey.days)
                Spacer()
            }
            HStack {
                Text("Color")
                Color(uiColor: getUIColor(color: journey.color))
                    .cornerRadius(20)
                    .frame(width: 30, height: 30)
                Picker("", selection: $journey.color) {
                    ForEach(AllowedColor.allCases) {
                        color in Text(color.rawValue).tag(color)
                    }
                }
            }
        }
    }
}
