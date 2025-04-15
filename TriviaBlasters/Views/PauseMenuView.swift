//
//  PauseMenuView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//


import SwiftUI

struct PauseMenuView: View {
    @Binding var isPaused: Bool // Controls pause state
    @Environment(\.presentationMode) var presentationMode // Allows going back to the main menu
    
    var body: some View {
        ZStack {
            // Space-themed gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Paused")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .blue, radius: 5) // Glow effect
                
                Button(action: {
                    isPaused = false // Resume game
                }) {
                    Text("Resume")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.8))
                                .shadow(color: .blue, radius: 10) // Futuristic glow
                        )
                }
                
                // Back to Main Menu button using presentationMode for dismissal
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss to go back to main menu
                }) {
                    Text("Main Menu")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.8))
                                .shadow(color: .purple, radius: 10) // Futuristic glow
                        )
                }
            }
        }
    }
}

#Preview {
    PauseMenuView(isPaused: .constant(true))
}
