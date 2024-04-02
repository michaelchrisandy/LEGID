//
//  CoundownTimerView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 27/03/24.
//

import SwiftUI

struct CoundownTimerView: View {
    @State private var remainingSeconds = 10
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
                   Text("Countdown Timer")
                       .font(.title)

                   Text("Remaining Time: \(remainingSeconds)")
                       .font(.headline)
                       .padding()

                   Button("Start Timer") {
                       startTimer()
                   }
                   .padding()
               }
    }
    
    private func startTimer() {
            timer?.invalidate()  // Stop any existing timer
            remainingSeconds = 10
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                } else {
                    timer?.invalidate()  // Stop the timer when countdown reaches 0
                }
            }
        }
    
}

#Preview {
    CoundownTimerView()
}
