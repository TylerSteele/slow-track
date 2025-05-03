//
//  DaysPicker.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/29/24.
//

import SwiftUI
import SwiftData

struct DaysPicker: View {
    @Binding var selectedDays: [Day]
    var body: some View {
        HStack {
            ForEach(Day.allCases, id: \.self) { day in
                Text(String(day.caseName.prefix(2)))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(selectedDays.contains(day) ? Color.cyan.cornerRadius(20) : Color.gray.cornerRadius(5))
                    .overlay(
                        selectedDays.contains(day) 
                        ? RoundedRectangle(cornerRadius: 20).stroke(.blue, lineWidth: 4)
                        : nil)
                    .onTapGesture {
                        withAnimation {
                            if selectedDays.contains(day) {
                                selectedDays.removeAll(where: {$0 == day})
                            } else {
                                selectedDays.append(day)
                            }
                        }
                    }
            }
        }
    }
}


#Preview {
    struct BindingViewExamplePreviewContainer : View {
        @State private var value = [Day.Monday, Day.Wednesday]

       var body: some View {
           DaysPicker(selectedDays: $value)
       }
    }

    return BindingViewExamplePreviewContainer()
}

enum Day: Int, CaseIterable, Codable, Hashable {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

extension Day {
    var caseName: String {
        return String(describing: self)
    }
}
