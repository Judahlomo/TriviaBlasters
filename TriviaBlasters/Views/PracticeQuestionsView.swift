//
//  PracticeQuestionsView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PracticeQuestionsView: View {
    @EnvironmentObject var triviaQuestionsModel: TriviaQuestionsModel
    @State var questionToPractice: Question?
    @State var practicing = false
    @State var encouragement = false
    
    /*
     This view creates a list of all questions in the triviaQuestionsModel.questions array
     It also links them to a PopupQuestionView if the list item is clicked
    */
    var body: some View {
        if practicing {
            PopupQuestionView(question: questionToPractice!, onCorrectAnswer: { practicing = false; encouragement = false }, onIncorrectAnswer: { encouragement = true })
            if encouragement {
                Text("Incorrect. Try again!")
            }
            //Note: the else prevents the popup from being on the screen at the same time as the list. Eliminating the else and just having the List outside the if practicing {} statement is an interesting effect, but I'm not sure which I like best.
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
    }
}

/*
 Currently unused view... Could be useful if we want the rows to have more info in them, like an icon or something. That would require extra tracking of things
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
