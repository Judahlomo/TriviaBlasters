//
//  PopupQuestionView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PopupQuestionView: View {
    //use the below var to dismiss popup during game
    @Environment(\.dismiss) var dismiss

    @State var question: Question
    @State var selectedOption: String? //Currently unused, but... what if we made this a binding so we could "return" if the answer was correct during gameplay?
   let onCorrectAnswer: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .bold()
            
            ForEach(question.options, id: \.self) { option in
                HStack {
                    Button {
                        selectedOption = option
                        if selectedOption == question.answer {
                            onCorrectAnswer()
                            dismiss()
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
            }
        }
    }
}

#Preview {
    PopupQuestionView(question: Question(id: 1, question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"]), onCorrectAnswer: {print("Correct, now do stuff elsewhere")})
}
