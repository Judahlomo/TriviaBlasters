//
//  MainMenuView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var triviaQuestions: TriviaQuestionsModel

    var body: some View {
        NavigationStack {
            ZStack {
                // Space Image Background
                Image("Space")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer(minLength: 100)
                    
                    // Title
                    Text("Trivia Blasters")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .blue.opacity(0.7), radius: 5)
                    
                    Spacer(minLength: 20)
                    
                    // Menu Buttons (Shop & Customize removed)
                    VStack(spacing: 20) {
                        NavigationLink(destination: GameView()) {
                            menuButton(title: "New Game", colors: [Color.blue, Color.purple])
                        }
                        NavigationLink(destination: PracticeQuestionsView()) {
                            menuButton(title: "Practice Trivia", colors: [Color.orange, Color.green])
                        }
                        NavigationLink(destination: SettingsView()) {
                            menuButton(title: "Settings", colors: [Color.green, Color.blue])
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    private func menuButton(title: String, colors: [Color]) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: 250)
            .background(
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                    .shadow(color: colors.first ?? .white, radius: 5)
            )
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .environmentObject(TriviaQuestionsModel())
    }
}
