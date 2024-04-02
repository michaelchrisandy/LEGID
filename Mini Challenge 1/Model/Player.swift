//
//  Player.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 28/03/24.
//

import SwiftUI

@Observable class Player : Identifiable{
    var id: String
    var name: String
    var idea: String
    var role: String
    
    init(id: String, name: String, idea: String, role: String) {
        self.id = id
        self.name = name
        self.idea = idea
        self.role = role
    }
    
    
}
