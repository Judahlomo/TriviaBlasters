//
//  SettingsView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var soundEnabled: Bool = true
    
    var body: some View {
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
                
                NavigationLink(destination: MainMenuView()) {
                    Text("Back to Menu")
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
