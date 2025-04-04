//
//  Destination.swift
//  iTour
//
//  Created by Esther Ramos on 02/04/25.
//

import Foundation
import SwiftData

//Step 1 -> create the class of the things you want to save
//Step 2 -> create a model macro before the class (the @Model that goes above)
//Step 3 -> Go to the iTourApp file and add a view modifier to our window group when the app launches.



@Model

class Destination {
    //Name of the destination, details about that place, a date for when they arrive, and a priority (1.low,2.medium,3.high)
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]() //just by adding it like this, SwiftData already know that there will be many sights
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.name = name
        self.priority = priority
    }
}
