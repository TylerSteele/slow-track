//
//  JourneyListCard.swift
//  Slow Track
//
//  Created by Tyler Steele on 4/25/25.
//

import SwiftUI


struct JourneyListCard: View {
    @State private var isChecked: Bool = false
    var journey: Journey
    var body: some View {
        HStack {
            NavigationLink {
                JourneyEditor(journey: journey)
                Text("Journey")
            } label: {
                HStack {
                    Color(uiColor: getUIColor(color: journey.color))
                        .cornerRadius(20)
                        .frame(width: 30, height: 30)
                    Text(journey.title == "" ? "New Journey" : journey.title)
                    Spacer()
                    Toggle(isOn: $isChecked, label: getLabel)
                        .toggleStyle(CheckboxToggleStyle())
                }
            }
        }
    }
}
