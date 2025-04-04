//
//  Sight.swift
//  iTour
//
//  Created by Esther Ramos on 03/04/25.
//

import Foundation
import SwiftData

//you can later add other things if you want such as if it is they priority or not, etc
@Model
class Sight {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
