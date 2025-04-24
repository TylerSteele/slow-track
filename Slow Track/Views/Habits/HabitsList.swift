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
    return Text("Check")
}
struct JourneysList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var journeys: [Journey]
    @State private var boolean: Bool = false
    var body: some View {
        List {
            ForEach(journeys) { journey in
                HStack {
                    Toggle(isOn: $boolean, label: getLabel)
                        .toggleStyle(CheckboxToggleStyle())
                    NavigationLink {
                        JourneyEditor(journey: journey)
                        Text("Journey")
                    } label: {
                        HStack {
                            Color(uiColor: getUIColor(color: journey.color))
                                .cornerRadius(20)
                                .frame(width: 30, height: 30)
                            Text(journey.title == "" ? "New Journey" : journey.title)
                        }
                    }
                }
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

            configuration.label

        }
    }
}
