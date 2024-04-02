//
//  LobbyView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 26/03/24.
//

import SwiftUI
import FirebaseDatabaseInternal
import Firebase

struct LobbyView: View {
    @State var room : Room = Room()
    @State var topic: String = ""
    
    @State var isMaster = false
    
    @State private var navigateToInputIdea = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(room.topic)
                
                List (room.players){player in
                    Text(player.name)
                }
                
                
                if(isMaster){
                    NavigationLink(destination: inputIdeaView()) {
                        Text("Start Discussion")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onTapGesture {
                        GlobalMethod.updateRoomStatus(to: 2)
                    }
                }
                else{
                    Text("Waiting for the room master to start")
                }
            }
        }.onAppear{
            let roomCode = GlobalMethod.getRoomCode()
            let postRef = Database.database().reference().child(roomCode!)
            
            
            checkUserRole()
            
            _ = postRef.observe(DataEventType.value, with: { snapshot in
                guard snapshot.exists() else {
                    print("No data available")
                    return
                }
                
                if let value = snapshot.value as? [String: Any] {
                    mapValue(value: value)
                }
            })
            
            
        }
        .navigationDestination(
            isPresented: $navigateToInputIdea){
                inputIdeaView()
            }
        
        
    }
    
    func mapValue(value: [String: Any]){
        print("keganti")
        room.id = GlobalMethod.getRoomCode()!
        
        let info = value["info"] as! [String: Any]
        
        room.topic = info["topic"] as! String
        room.status = info["status"] as! Int
        room.explainIdeaTurn = info["explainIdeaTurn"] as! String
        room.commentIdeaTurn = info["commentIdeaTurn"] as! String
        
        let valuePlayer = value["players"] as! [String: [String:Any]]
        
        
        var newPlayers : [Player] = []
        for (id, data) in valuePlayer {
            newPlayers.append(Player(id: id, name: data["name"] as! String,  idea: data["idea"] as! String, role: data["role"] as! String))
        }
        
        room.players = newPlayers
        
        if(room.status == 2){
            navigateToInputIdea = true
        }
    }
    
    
    func checkUserRole() {
        GlobalMethod.isMaster { isValid in
            if isValid {
                isMaster = true
                print("User is a master")
            } else {
                isMaster = false
                print("User is not a master")
            }
        }
    }
    
}

#Preview {
    LobbyView()
}
