//
//  HabitEditor.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/28/24.
//

import SwiftUI

struct HabitEditor: View {
    @Bindable var habit: Habit
    
    var body: some View {
        List {
            HStack {
                Text("Title")
                Spacer()
                TextField("Title", text: $habit.title)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Motivation")
                Spacer()
                TextField("Motivation", text: $habit.motivation)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            VStack {
                Text("Schedule")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                DaysPicker(selectedDays: $habit.days)
                Spacer()
            }
            HStack {
                Text("Color")
                Color(uiColor: getUIColor(color: habit.color))
                    .cornerRadius(20)
                    .frame(width: 30, height: 30)
                Picker("", selection: $habit.color) {
                    ForEach(AllowedColor.allCases) {
                        color in Text(color.rawValue).tag(color)
                    }
                }
            }
        }
    }
}
