//
//  CustomizeView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct CustomizeView: View {
    @Environment(\.presentationMode) var presentationMode // Allows going back to the previous view
    
    var body: some View {
        ZStack {
            // Gradient background for a more visually appealing look
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all) // Full-screen gradient background
            
            VStack(spacing: 40) {
                // Title: Customize Your Ship
                Text("Customize Your Ship")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                Spacer()
                
                // Back to Menu Button using presentationMode for dismissal
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss to go back to the main menu
                }) {
                    Text("Back to Menu")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black.opacity(0.7))
                                .shadow(color: .purple, radius: 10) // Glowing effect
                        )
                        .padding(.bottom, 40) // Padding for positioning
                }
            }
            .padding() // Adds some space around the edges
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView()
    }
}
