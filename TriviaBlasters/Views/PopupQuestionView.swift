//
//  PopupQuestionView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PopupQuestionView: View {

    @State var question: Question
    @State var selectedOption: String? //Used for determining button label reactions
    let onCorrectAnswer: () -> Void
    let onIncorrectAnswer: () -> Void
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(question.question)
                    .bold()
                
                ForEach(question.options.shuffled(), id: \.self) { option in
                    HStack {
                        Button {
                            selectedOption = option
                            if selectedOption == question.answer {
                                onCorrectAnswer()
                                //isPresented = false
                            } else {
                                onIncorrectAnswer()
                            }
                        } label: {
                            if selectedOption == option {
                                Circle()
                                    .frame(width: 20, height: 20)
                            } else {
                                Circle()
                                    .stroke()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.horizontal)
                        
                        Text(option)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    PopupQuestionView(question: Question(id: 1, question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"]), onCorrectAnswer: {print("Correct, now do stuff elsewhere")}, onIncorrectAnswer: {print("Incorrect, now do stuff elsewhere")})
}
