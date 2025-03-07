//
//  PracticeQuestionsView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PracticeQuestionsView: View {
    @EnvironmentObject var triviaQuestionsModel: TriviaQuestionsModel
    
    //This won't be useful once triviaQuestionsModel is fully working
    @State var questions: [Question] = [Question(question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"], learned: true),
                                        Question(question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"], learned: false),
                                        Question(question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"], learned: true),
                                        Question(question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"], learned: false),
                                        Question(question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"], learned: false)]
    
    @State private var stackPath: [Question] = []
    
    var body: some View {
        //Currently, NavigationStack functionality is not working
        NavigationStack (path: $stackPath) {
            List {
                ForEach(questions, id: \.self) {q in
                    NavigationLink(value: q) {
                        QuestionRowView(question: q)
                    }
                }
            }
        }
        .navigationTitle("Trivia")
        .navigationDestination(for: Question.self) {q in
                PopupQuestionView(question: q)
        }
    }
}

struct QuestionRowView: View {
    var question: Question
    
    var body: some View {
        HStack {
            //Could try darkening/fading view if question is not learned?
            Image(systemName: "checkmark")
                .foregroundColor(question.learned ? .green : .white)
            Text(question.question)
        }
    }
}

#Preview {
    PracticeQuestionsView()
        .environmentObject(TriviaQuestionsModel())
}
