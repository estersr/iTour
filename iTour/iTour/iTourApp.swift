//
//  iTourApp.swift
//  iTour
//
//  Created by Esther Ramos on 02/04/25.
//

import SwiftUI
import SwiftData

//Step 3 -> Go to the iTourApp file and add a view modifier to our window group when the app launches.

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
