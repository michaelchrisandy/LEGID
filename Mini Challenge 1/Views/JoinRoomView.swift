//
//  JoinRoomView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 25/03/24.
//

import SwiftUI
import Firebase

struct JoinRoomView: View {
    
    @State private var name: String = ""
    @State private var roomCode: String = ""
    @State private var isButtonDisabled = true
    
    @State private var navigateToLobby = false
    
    var body: some View {
        NavigationStack{
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter room code", text: $roomCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            
            Button("Join room") {
                // Validate input
                validateRoomCode(code: roomCode){ isValid in
                    if isValid{
                        print("ada roomnya")
                        let userID = UserDefaults.standard.string(forKey: "userID")!
                        
                        let ref = Database.database().reference()
                        
                        ref.child(roomCode).child("players").child(userID).child("name").setValue(name)
                        
                        ref.child(roomCode).child("players").child(userID).child("role").setValue("member")
                        
                        ref.child(roomCode).child("players").child(userID).child("idea").setValue(" ")
                        
                        UserDefaults.standard.set(roomCode, forKey: "roomCode")
                        
                        navigateToLobby = true
                    }
                    else{
                        print("gaada roomnya")
                    }
                }
                
            }
            .padding()
            .background(isButtonDisabled ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(isButtonDisabled)
            .onChange(of: name) {
                validateInputs()
            }
            .onChange(of: roomCode) {
                validateInputs()
            }
            .navigationDestination(
                isPresented: $navigateToLobby){
                    LobbyView()
                }
            
//            NavigationLink(destination: LobbyView(), isActive: $navigateToLobby) {
//                EmptyView()
//            }
            
//            NavigationLink(
//                    destination: LobbyView(),
//                    tag: true,
//                    selection: $navigateToLobby,
//                    label: { EmptyView() }
//                )
            
            
        }
        
    }
    
    func validateInputs() {
        isButtonDisabled = name.isEmpty || roomCode.isEmpty
    }
    
    func validateRoomCode(code: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child(code)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                print("No data available")
                completion(false)
                return
            }
            
            // Process the data
            if let value = snapshot.value as? [String: Any] {
                // Assuming the data is a dictionary, you can access its values
                // For example, if the data contains a "name" key
                if let name = value["name"] as? String {
                    print("Name: \(name)")
                }
                // You can access other keys in a similar way
            }
            completion(true)
        }
    }
}

#Preview {
    JoinRoomView()
}
