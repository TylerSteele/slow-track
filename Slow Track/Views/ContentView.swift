//
//  ContentView.swift
//  Slow Track
//
//  Created by Tyler Steele on 4/3/24.
//

import SwiftUI
import UIKit

struct ContentView: View {

    var body: some View {
        NavigationSplitView {
            HabitsList()
        } detail: {
            Text("Select a habit")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
