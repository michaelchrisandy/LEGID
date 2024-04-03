//
//  DiscussionView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 03/04/24.
//

import SwiftUI
import Firebase

struct DiscussionView: View {
    
    @State var room : Room = Room()
    
    @State private var counter = 60
    @State private var timer: Timer?
    
    @State var isMaster = false
    
    var body: some View {
        VStack{
            Text("idenya")
            Text("ide siapa")
            Text("Sisa waktu: \(counter)")
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
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateCounter()
        }
    }
    
    func updateCounter(){
        counter -= 1
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
    
    func mapValue(value: [String: Any]){
        print("keganti")
        room.id = GlobalMethod.getRoomCode()!
        
        let info = value["info"] as! [String: Any]
        
        room.topic = info["topic"] as! String
        room.status = info["status"] as! Int
        room.explainIdeaTurn = info["explainIdeaTurn"] as! String
        room.commentIdeaTurn = info["commentIdeaTurn"] as! String
        room.ideaSubmitted = info["ideaSubmitted"] as! Int
        
        let valuePlayer = value["players"] as! [String: [String:Any]]
        
        
        var newPlayers : [Player] = []
        for (id, data) in valuePlayer {
            newPlayers.append(Player(id: id, name: data["name"] as! String,  idea: data["idea"] as! String, role: data["role"] as! String))
        }
        
        room.players = newPlayers
        
        if(room.ideaSubmitted == room.players.count){
            let ref = Database.database().reference()
            
            ref.child(room.id).child("info").child("status").setValue(3)
        }
    }
    
    
}


//#Preview {
//    DiscussionView()
//}
