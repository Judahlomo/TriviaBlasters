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
    @State var questionToPractice: Question?
    @State var practicing = false
    @State var encouragement = false
    
    //@State private var stackPath: [Question] = []
    
    /*
     This view creates a list of all questions in the triviaQuestionsModel.questions array
     It also links them to a PopupQuestionView if the list item is clicked
    */
    var body: some View {
        //NavigationStack (path: $stackPath) {
//            List {
//                ForEach(triviaQuestionsModel.questions, id: \.self) {q in
//                    NavigationLink(value: q) {
//                        QuestionRowView(question: q)
//                    }
//                }
//            }
//            .navigationTitle("Trivia")
//            .navigationDestination(for: Question.self) {q in
//                PopupQuestionView(question: q, onCorrectAnswer: {triviaQuestionsModel.learnedQuestion(q: q)})
//            }
        if practicing {
            PopupQuestionView(/*isPresented: $practicing, */question: questionToPractice!, onCorrectAnswer: { practicing = false; encouragement = false }, onIncorrectAnswer: { encouragement = true })
            if encouragement {
                Text("Incorrect. Try again!")
            }
            //Note: if this else is not there, it's just a popup on the screen with the list still present. Which is kind of cool, I think...
        } else {
            
            List(triviaQuestionsModel.questions) { question in
                if question.learned {
                    Button {
                        questionToPractice = question
                        practicing = true
                    } label: {
                        Text(question.question)
                    }
                }
            }
            .navigationTitle("Trivia")
        }
//        List(triviaQuestionsModel.questions) { question in
//                NavigationLink(value: question) {
//                    QuestionRowView(question: question)
//                }
//            }
//            .navigationTitle("Trivia")
//            .navigationDestination(for: Question.self) {q in
//                PopupQuestionView(question: q, onCorrectAnswer: {triviaQuestionsModel.learnedQuestion(q: q)})
//            }
        //}
    }
}

/*
 Currently unused view...
*/
struct QuestionRowView: View {
    var question: Question
    
    var body: some View {
        HStack {
            Text(question.question)
        }
    }
}

#Preview {
    PracticeQuestionsView()
        .environmentObject(TriviaQuestionsModel())
}
