//
//  Mini_Challenge_1App.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 24/03/24.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if UserDefaults.standard.string(forKey: "userID") == nil {
            setID()
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) { //kadang ga kepanggil
        print("app ketutup")
        
        if UserDefaults.standard.string(forKey: "roomCode") != nil {
            print("app will terminate")
            
            let roomCode = UserDefaults.standard.string(forKey: "roomCode")!
            let userID = UserDefaults.standard.string(forKey: "userID")!
            
            
            let ref = Database.database().reference().child(roomCode).child("players").child(userID)
            
            ref.removeValue { error, _ in
                if let error = error {
                    print("Failed to delete data: \(error)")
                } else {
                    print("Data deleted successfully")
                }
            }
            
            UserDefaults.standard.removeObject(forKey: "roomCode")
        }
        
        UserDefaults.standard.removeObject(forKey: "userID")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("will resign active")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("did enter background")
    }
    
    
    func setID(){
        let userID = randomString(length: 20)
        
        UserDefaults.standard.set(userID, forKey: "userID")
//        
//        let ref = Database.database().reference()
//        ref.child(userID).child("name").setValue("mike")
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
}

@main
struct Mini_Challenge_1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            LobbyView()
            RoomView()
//            CoundownTimerView()
        }
    }
}
