//
//  Room.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 28/03/24.
//

import SwiftUI

@Observable class Room : Identifiable{
    var id: String
    var topic: String
    var status: Int
    var explainIdeaTurn: String
    var commentIdeaTurn: String
    
    var players: [Player]

    init() {
        self.id = " "
        self.topic = " "
        self.status = 0
        self.explainIdeaTurn = " "
        self.commentIdeaTurn = " "
        
        self.players = []
    }
    
    func setPlayer(players: [Player]){
        self.players = players
    }
    
    func addPlayer(player: Player) {
        players.append(player)
    }

    func removePlayer(withID id: String) {
        players.removeAll { $0.id == id }
    }
}
