//
//  JourneysList.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/22/24.
//

import SwiftUI
import SwiftData

// TODO settle on a good toggle design 

func getLabel () -> Text {
    return Text("Label")
}
struct JourneysList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var journeys: [Journey]
    var body: some View {
        List {
            ForEach(journeys) { journey in
                JourneyListCard(journey: journey)
            }
            .onDelete(perform: deleteJourney)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addJourney) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    private func addJourney() {
        withAnimation {
            let newJourney = Journey()
            modelContext.insert(newJourney)
        }
    }
    
    private func deleteJourney(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(journeys[index])
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        JourneysList()
    } detail: {
        Text("Select an item")
    }
        .modelContainer(for: [Journey.self], inMemory: true)
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }

//            configuration.label   I don't want a label. Maybe this is an accessibility concern, but the check is only temporary.

        }
    }
}

