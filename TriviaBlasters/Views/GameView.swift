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
    @State private var triviaTrigger = false
    @State private var question: Question? = nil
    
    @EnvironmentObject var triviaModel: TriviaQuestionsModel
    
    @StateObject var engine = GameEngine()
    
    var scene: SKScene {
        engine.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        engine.scaleMode = .resizeFill
        return engine
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .edgesIgnoringSafeArea(.all)
            
            if isPaused {
                PauseMenuView(isPaused: $isPaused)
            }
            
            if triviaTrigger, let currentQ = question {
                PopupQuestionView(
                    question: currentQ,
                    onCorrectAnswer: {
                        triviaModel.learnedQuestion(q: currentQ)
                        engine.endTrivia()
                        triviaTrigger = false
                    },
                    onIncorrectAnswer: {
                        //engine.loseLife()
                        engine.endTrivia()
                        triviaTrigger = false
                    }
                )
            }
            
            if engine.isGameOver {
                GameOverView {
                    engine.resetGame()
                }
                .transition(.opacity)
                .zIndex(2)
            }
            
            
            VStack {
                HStack {
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
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("TriggerTriviaPopup"), object: nil, queue: .main) { _ in
                self.triviaTrigger = true
                self.question = triviaModel.randomQuestion()
            }
        }
    }
}
