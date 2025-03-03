//
//  PauseMenuView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct PauseMenuView: View {
    @Binding var isPaused: Bool // Controls pause state
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7) // Dark overlay
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Paused")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Button(action: {
                    isPaused = false // Resume game
                }) {
                    Text("Resume")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: MainMenuView()) {
                    Text("Main Menu")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
