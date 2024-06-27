//
//  HabitsList.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/22/24.
//

import SwiftUI
import SwiftData

struct HabitsList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    var body: some View {
        List {
            ForEach(habits) { habit in
                NavigationLink {
                    HabitEditor(habit: habit)
                    Text("Habit")
                } label: {
                    HStack {
                        Color(uiColor: getUIColor(color: habit.color))
                            .cornerRadius(20)
                            .frame(width: 30, height: 30)
                        Text(habit.title == "" ? "New Habit" : habit.title)
                    }
                }
            }
            .onDelete(perform: deleteHabit)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addHabit) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    private func addHabit() {
        withAnimation {
            let newHabit = Habit()
            modelContext.insert(newHabit)
        }
    }
    
    private func deleteHabit(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(habits[index])
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        HabitsList()
    } detail: {
        Text("Select an item")
    }
        .modelContainer(for: [Habit.self], inMemory: true)
}
