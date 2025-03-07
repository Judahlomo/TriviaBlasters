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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
