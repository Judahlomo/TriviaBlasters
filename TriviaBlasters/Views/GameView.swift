//
//  GameView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @State private var isPaused = false
    
    @EnvironmentObject var triviaModel: TriviaQuestionsModel
    @State private var triviaPause = false
    @State private var answeredCorrectly = false

    var scene: SKScene {
        let scene = GameEngine()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        ZStack {
            SpriteView(scene: scene) //
                .edgesIgnoringSafeArea(.all) // Ensure full screen

            if isPaused {
                PauseMenuView(isPaused: $isPaused)
            }
            
            if triviaPause {
                let q = triviaModel.randomQuestion()
                PopupQuestionView(/*isPresented: $triviaPause, */question: q, onCorrectAnswer: { triviaModel.learnedQuestion(q: q); answeredCorrectly = true; triviaPause = false }, onIncorrectAnswer: { answeredCorrectly = false; triviaPause = false })
            }

            VStack {
                HStack {
                    Button(action: { triviaPause = true }) {
                        Text("Trivia Trigger")
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
                    }
                    Spacer()
                    Button(action: { isPaused = true }) {
                        Text("Pause")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(TriviaQuestionsModel()) //For integrating trivia into previews
    }
}
