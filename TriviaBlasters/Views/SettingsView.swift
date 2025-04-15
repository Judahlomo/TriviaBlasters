//
//  SettingsView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var soundEnabled: Bool = true
    @Environment(\.presentationMode) var presentationMode // Allows going back
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // Background
                
                VStack(spacing: 20) {
                    Text("Settings")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    Toggle("Sound Effects", isOn: $soundEnabled)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    // Back to Menu Button
                    Button(action: {
                        // This will dismiss the current view and go back to the previous screen
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Back to Menu")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                .navigationBarBackButtonHidden(true) // Hide default back button if you want to customize
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
