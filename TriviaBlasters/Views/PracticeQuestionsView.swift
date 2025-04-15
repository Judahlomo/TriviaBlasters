//
//  PracticeQuestionsView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//


/* Notes on this file...
 NavigationStack, with the accompanying stackPath variable, is used to create the NavigationLink to the PopupQuestionView. stackPath is an array of Ints intentionally, because that allows bindings to be passed to QuestionRowViews, which is useful for a reactive list.
 Later, we could do something where this list only shows learned questions. Then the user would be forced to play the game to encounter new questions and unlock them that way.
 
 
 */

import SwiftUI

struct PracticeQuestionsView: View {
    @EnvironmentObject var triviaQuestionsModel: TriviaQuestionsModel
    
    @State private var stackPath: [Int] = []
    
    /*
     This view creates a list of all questions in the triviaQuestionsModel.questions array
     It also links them to a PopupQuestionView if the list item is clicked
    */
    var body: some View {
        NavigationStack (path: $stackPath) {
            List {
                ForEach(0..<triviaQuestionsModel.questions.count, id: \.self) {q in
                    NavigationLink(value: q) {
                        QuestionRowView(question: triviaQuestionsModel.questions[q])
                    }
                }
            }
            .navigationTitle("Trivia")
            .navigationDestination(for: Int.self) {q in
                PopupQuestionView(question: triviaQuestionsModel.questions[q], onCorrectAnswer: {triviaQuestionsModel.learnedQuestion(q: q)})
            }
        }
    }
}

/*
 Real simple view, just shows a checkmark if the question has been learned.
 That functionality may have to go away if we implement the stuff mentioned in my note above
 */
struct QuestionRowView: View {
    var question: Question
    
    var body: some View {
        HStack {
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
