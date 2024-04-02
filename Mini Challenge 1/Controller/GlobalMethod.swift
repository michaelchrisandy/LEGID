//
//  GlobalMethod.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 29/03/24.
//

import SwiftUI
import Firebase

class GlobalMethod {
    static func getRoomCode() -> String? {
        return UserDefaults.standard.string(forKey: "roomCode")
    }
    
    static func getUserID() -> String? {
        return UserDefaults.standard.string(forKey: "userID")
    }
    
    static func isMaster(completion: @escaping (Bool) -> Void) {
        let userID = getUserID()
//        print(userID)
        let ref = Database.database().reference().child(getRoomCode()!).child("players").child(userID!).child("role")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                print("No data available")
                completion(false) // Call completion with false if snapshot doesn't exist
                return
            }
            
            // Process the data
            if let value = snapshot.value as? String {
                print(value)
                if value == "master" {
                    print("ganti ke true")
                    completion(true) // Call completion with true if value is "master"
                } else {
                    completion(false) // Call completion with false if value is not "master"
                }
            } else {
                completion(false) // Call completion with false if value is not a string
            }
        }
    }
    
    static func updateRoomStatus(to: Int){
        let ref = Database.database().reference()
        ref.child(getRoomCode()!).child("info").child("status").setValue(to)
    }
    
    
}
