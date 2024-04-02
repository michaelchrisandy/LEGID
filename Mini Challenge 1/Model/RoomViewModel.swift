//
//  RoomViewModel.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 28/03/24.
//

import SwiftUI
import Firebase

class RoomViewModel: ObservableObject {
    @Published var room: Room?
    
    private var ref: DatabaseReference = Database.database().reference().child("room")
    private var handle: DatabaseHandle?

    init() {
        fetchRoom()
    }

    func fetchRoom() {
        handle = ref.observe(.value, with: { snapshot in
            if let value = snapshot.value as? [String: Any],
               let id = value["id"] as? String,
               let name = value["name"] as? String,
               let playersData = value["players"] as? [[String: Any]] {
                var players: [Player] = []
                for playerData in playersData {
                    if let playerId = playerData["id"] as? String,
                       let playerName = playerData["name"] as? String {
                        let player = Player(id: playerId, name: playerName)
                        players.append(player)
                    }
                }
                self.room = Room(id: id, name: name, players: players)
            } else {
                self.room = nil
            }
        })
    }

    deinit {
        if let handle = handle {
            ref.removeObserver(withHandle: handle)
        }
    }
}
