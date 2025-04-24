//
//  TriviaBlastersApp.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

@main
struct TriviaBlastersApp: App {
    @StateObject private var triviaQuestions = TriviaQuestionsModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(triviaQuestions)
        }
    }
}


