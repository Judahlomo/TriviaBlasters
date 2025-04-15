//
//  GameView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct GameView: View {
    @State private var isPaused = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Placeholder background
            
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
