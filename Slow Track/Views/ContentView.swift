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
            JourneysList()
        } detail: {
            Text("Select a journey")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Journey.self, inMemory: true)
}
