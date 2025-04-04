//
//  DestinationListingView.swift
//  iTour
//
//  Created by Esther Ramos on 02/04/25.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    var body: some View {
        List {
            
            ForEach(destinations) { destination in
                
                NavigationLink(value: destination) {
                    VStack (alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                        
                    }
                }
                
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    
    // A new initializer that takes a sort option with some kind of SortDescriptor that applies to the Destination model.
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            //if searchString is empty, then show all objects, else return that object name having a localized contains of our searchString
               if searchString.isEmpty {
                   return true
               } else {
                   return $0.name.localizedStandardContains(searchString)
               }
        },
            sort: [sort])
        
    }
    
    
    //Step 6: Thats how you delete items in SwiftData
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
