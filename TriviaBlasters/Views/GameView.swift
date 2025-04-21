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
    @State private var triviaTrigger = false
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
            
            //This code responds to the triviaTrigger variable. Note that it does not actually pause the game.
            if triviaTrigger {
                let q = triviaModel.randomQuestion()
                PopupQuestionView(question: q, onCorrectAnswer: { triviaModel.learnedQuestion(q: q); answeredCorrectly = true; triviaTrigger = false }, onIncorrectAnswer: { answeredCorrectly = false; triviaTrigger = false })
            }

            VStack {
                HStack {
                    //This is a temporary button used to test how the trivia popup would work. The real event to trigger the popup should be something else. Unless we like the button (like use it if you want to try for a powerup or something).
                    Button(action: { triviaTrigger = true }) {
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
