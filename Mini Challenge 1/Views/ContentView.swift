//
//  ContentView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 24/03/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var counter = 0
    @State private var timer: Timer?
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Counter: \(counter)")
                
                Button(action: {
                                writeData()
                            }) {
                                Text("Write Data")
                            }
                
                NavigationLink(destination: HomeView()) {
                    Text("Go to Home Page")
                }
            }
            .padding()
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateCounter()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateCounter() {
        counter += 1
    }
    
    func writeData() {
        let ref = Database.database().reference()
//        ref.child("message").setValue("Hello, Firebase!")
        
        ref.child("123").child("456").setValue("hi")
        ref.child("123").child("333").setValue("heho")
    }
}

#Preview {
    ContentView()
}
