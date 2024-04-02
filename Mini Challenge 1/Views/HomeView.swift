//
//  HomeView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 24/03/24.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State private var name: String = ""
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter your name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                
                NavigationLink(destination: RoomView()) {
                                    Text("Confirm")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    print(UserDefaults.standard.string(forKey: "userID"))
                            }) {
                                Text("Write Data")
                            }
            }
        }
        .onAppear{
//            print(UserDefaults.standard.string(forKey: "userID"))
            if UserDefaults.standard.string(forKey: "userID") == nil {
                setID()
            }
        
        }
        .onChange(of: scenePhase) {
                    if scenePhase == .background {
                        print("background")
                        
                        let userID = UserDefaults.standard.string(forKey: "userID")
                        
                        let ref = Database.database().reference().child(userID!)
                        
                        ref.removeValue { error, _ in
                            if let error = error {
                                print("Failed to delete data: \(error)")
                            } else {
                                print("Data deleted successfully")
                            }
                        }
                        
                        UserDefaults.standard.removeObject(forKey: "userID")
                        
                        print("end of background : \(UserDefaults.standard.string(forKey: "userID"))")
                    }
                }

        
    }
    
    func setID(){
        let userID = randomString(length: 20)
        
        UserDefaults.standard.set(userID, forKey: "userID")
        
        let ref = Database.database().reference()
        ref.child(userID).child("name").setValue("mike")
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
}

#Preview {
    HomeView()
}
