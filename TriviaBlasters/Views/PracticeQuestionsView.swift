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
    @State var answerResult: String? // ✅ New state for feedback

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.indigo, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if practicing {
                VStack(spacing: 20) {
                    PopupQuestionView(
                        question: questionToPractice!,
                        onCorrectAnswer: {
                            answerResult = "✅ Correct!"
                            encouragement = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                practicing = false
                                answerResult = nil
                            }
                        },
                        onIncorrectAnswer: {
                            answerResult = "❌ Incorrect. Try again!"
                            encouragement = true
                        }
                    )

                    if let result = answerResult {
                        Text(result)
                            .font(.headline)
                            .foregroundColor(result.contains("Correct") ? .green : .orange)
                            .padding()
                            .background(Color(red: 30/255, green: 30/255, blue: 40/255))
                            .cornerRadius(12)
                            .transition(.opacity)
                    }
                }
                .padding()
            } else {
                VStack(spacing: 16) {
                    Text("🪐 Practice Trivia")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)

                    List {
                        ForEach(triviaQuestionsModel.questions) { question in
                            if question.learned {
                                Button(action: {
                                    questionToPractice = question
                                    practicing = true
                                }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "sparkle")
                                            .foregroundColor(.purple)
                                        Text(question.question)
                                            .foregroundColor(.white)
                                    }
                                    .padding(8)
                                }
                                .listRowBackground(Color.black.opacity(0.2))
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PracticeQuestionsView()
        .environmentObject(TriviaQuestionsModel())
}
