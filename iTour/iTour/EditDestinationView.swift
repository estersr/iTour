//
//  EditDestinationView.swift
//  iTour
//
//  Created by Esther Ramos on 02/04/25.
//

import SwiftUI
import SwiftData

//MARK: Steps
//Step 7: if this view was only made for reading the date, we would write (var destination: Destination). But what we want is to bind them to texfields, pickers and edit values over time.
// For this step 7, you wil add a property wrapper called at Bindable which is able to create any kind of bindings for any Swift data project.
//Step 8: fix the preview with a temporary data usage.
//Step 9: UI
//Step 10: go back to the ContentView and make navigation work for out list, adding a NavigationLink inside of the ForEach, so every row on the list is navigation linked to a moving destination
struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    @State private var newSightName = ""
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            //after created the func, we will create a section that will loop over all the existing sights and add space below that to create new ones
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                
                HStack {
                    TextField("Add new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight) 
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //this will convert sightname into an actual site object and adds to our destinations existing lists of sights.
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
         // if we are still here
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        
        //Now the objects:
        
        let example = Destination(name: "Example destination", details: "Example details go here and will automatically expand vertically as they are edited")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create model container.")
    }
}
