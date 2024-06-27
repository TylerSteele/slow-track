//
//  Slow_TrackApp.swift
//  Slow Track
//
//  Created by Tyler Steele on 4/3/24.
//

import SwiftUI
import SwiftData

@main
struct Slow_TrackApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Habit.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
