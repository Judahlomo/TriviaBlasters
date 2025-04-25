//
//  GameOverView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//

import SwiftUI

struct GameOverView: View {
    let onRestart: () -> Void

    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            Button("New Game") {
                onRestart()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
    }
}
