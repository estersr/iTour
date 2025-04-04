//
//  ContentView.swift
//  iTour
//
//  Created by Esther Ramos on 02/04/25.
//

import SwiftData
import SwiftUI

// MARK: Steps
//Step 4 -> add a @Query variable in your struct. and it will use a new at query macro from SwiftData, reading all Destination objects stored on the database
//Step 5 -> Add an enviromnet var the model context, and then you will be able to insert the three pieces of data on the func AddSamples
//Step 6 -> delete items func in SwiftData.
//Step 7 -> EditDestinationView with a bindable property wrapper for editable data.
//Step 8 and 9 -> EditDestinationView
//Step 10: make navigation work for the list, adding a NavigationLink inside of the ForEach, so every row on the list is navigation linked to a moving destination. Also, you need to add a navigation destination below the nav title so SwiftUI no to move that editing view whenever a navigation is triggered
//Step 11: creating a storage to track the path of our navigationStack
//step 12: create an empty destination
//Step 13: Letting the user decide the sort order of the items. We will have to send this Query property down one view in Swift hierarchy, putting it in a subview, and we can inject a sort view using that Views Initializer. -> take it off this view, and add to DestinationListingView

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Date")
                            tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    //what this function basically do is: store this data for us only, but it's not being used thats where you need to understand the concept of Model Context.
    //Model Context has the job of tracking all objects that are currently beying used by the app, but thats not all the objects.
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        
        //Step 5:
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    
    //step 12: we are saying here "make that thing be shown in our navigation stack right now
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
