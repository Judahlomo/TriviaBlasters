//
//  PopupQuestionView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PopupQuestionView: View {
    //use the below var later to dismiss popup during game
    @Environment(\.dismiss) var dismiss
    //This pre-initializing may mess with the workings of the view once it is integrated into GameView
    @State var question: Question
    @State var selectedOption: String?
    
    init(question: Question = Question(id: 1, question: "What is the first letter of the alphabet?", answer: "A", options: ["G", "A", "Omega", "Z"])) {
        self.question = question
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .bold()
            
            ForEach(question.options, id: \.self) { option in
                HStack {
                    Button {
                        selectedOption = option
                        if selectedOption == question.answer {
                            print("Got it right!!")
                            //dismiss()
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
    PopupQuestionView()
}
