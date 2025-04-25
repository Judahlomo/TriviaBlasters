//
//  PopupQuestionView.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import SwiftUI

struct PopupQuestionView: View {

    @State var question: Question
    @State var selectedOption: String?
    let onCorrectAnswer: () -> Void
    let onIncorrectAnswer: () -> Void

    var body: some View {
        ZStack {
            // Solid space-themed background
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 24) {
                Text("🚀 Quiz Challenge")
                    .font(.headline)
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 20) {
                    Text(question.question)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)

                    ForEach(question.options.shuffled(), id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            if selectedOption == question.answer {
                                NotificationCenter.default.post(name: Notification.Name("CorrectAnswerNotification"), object: nil)
                                onCorrectAnswer()
                            } else {
                                NotificationCenter.default.post(name: Notification.Name("IncorrectAnswerNotification"), object: nil)
                                onIncorrectAnswer()
                            }
                        }) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 20, height: 20)
                                    if selectedOption == option {
                                        Circle()
                                            .fill(Color.green)
                                            .frame(width: 12, height: 12)
                                    }
                                }

                                Text(option)
                                    .foregroundColor(.white)
                                    .font(.body)

                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 30/255, green: 30/255, blue: 40/255)) // solid dark panel
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .background(Color(red: 20/255, green: 20/255, blue: 30/255)) // solid container
                .cornerRadius(16)
                .shadow(color: .black, radius: 10)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    PopupQuestionView(
        question: Question(
            id: 1,
            question: "What is the first letter of the alphabet?",
            answer: "A",
            options: ["G", "A", "Omega", "Z"]
        ),
        onCorrectAnswer: { print("Correct, now do stuff elsewhere") },
        onIncorrectAnswer: { print("Incorrect, now do stuff elsewhere") }
    )
}
