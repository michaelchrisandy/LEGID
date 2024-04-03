//
//  CreateRoomView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 25/03/24.
//

import SwiftUI
import Firebase

struct CreateRoomView: View {
    
    @State private var name: String = ""
    @State private var roomTopic: String = ""
    @State private var isButtonDisabled = true
    
    @State private var navigateToLobby = false
    
    var body: some View {
        TextField("Enter your name", text: $name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        
        TextField("Enter the topic", text: $roomTopic)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        
        Button("Create room") {
            let userID = UserDefaults.standard.string(forKey: "userID")!
            
            let roomCode = randomNumber(length: 6)
            
            let ref = Database.database().reference()
            
            ref.child(roomCode).child("players").child(userID).child("name").setValue(name)
            
            ref.child(roomCode).child("players").child(userID).child("role").setValue("master")
            
            ref.child(roomCode).child("players").child(userID).child("idea").setValue(" ")
            
            ref.child(roomCode).child("info").child("topic").setValue(roomTopic)
            
            ref.child(roomCode).child("info").child("status").setValue(1)
            
            ref.child(roomCode).child("info").child("explainIdeaTurn").setValue(" ")
            
            ref.child(roomCode).child("info").child("commentIdeaTurn").setValue(" ")
            
            ref.child(roomCode).child("info").child("ideaSubmitted").setValue(0)
            
            UserDefaults.standard.set(roomCode, forKey: "roomCode")
            
            navigateToLobby = true
        }
        
        .padding()
        .background(isButtonDisabled ? Color.gray : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
        .disabled(isButtonDisabled)
        .onChange(of: name) {
            validateInputs()
        }
        .onChange(of: roomTopic) {
            validateInputs()
        }
        .navigationDestination(
            isPresented: $navigateToLobby){
                LobbyView()
            }
    }
    
    func validateInputs() {
        isButtonDisabled = name.isEmpty || roomTopic.isEmpty
    }
    
    func randomNumber(length: Int) -> String {
        let numbers = "0123456789"
        return String((0..<length).map { _ in numbers.randomElement()! })
    }
}

#Preview {
    CreateRoomView()
}
