//
//  PlayerViewModel.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 28/03/24.
//

import SwiftUI
import Firebase

class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = []
    
    private var ref: DatabaseReference = Database.database().reference().child("players")
    private var handle: DatabaseHandle?

    init() {
        fetchPlayers()
    }

    func fetchPlayers() {
        handle = ref.observe(.value, with: { snapshot in
            var newPlayers: [Player] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let id = value["id"] as? String,
                   let name = value["name"] as? String {
                    let player = Player(id: id, name: name)
                    newPlayers.append(player)
                }
            }
            self.players = newPlayers
        })
    }

    deinit {
        if let handle = handle {
            ref.removeObserver(withHandle: handle)
        }
    }
}
