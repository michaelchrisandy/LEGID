//
//  RoomView.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 24/03/24.
//

import SwiftUI

struct RoomView: View {
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(destination: JoinRoomView()) {
                                    Text("Join room")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: CreateRoomView()) {
                                    Text("Create room")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
            }
        }
        
    }
}

#Preview {
    RoomView()
}
