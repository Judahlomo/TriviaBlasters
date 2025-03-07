//
//  TriviaQuestionsModel.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import Foundation

//The RawTrivia doc is supposed to be the JSON storage of questions. I'm looking around for more viable storage options.

class TriviaQuestionsModel: ObservableObject {
    @Published var knownQuestions: [Question] = []
    @Published var unknownQuestions: [Question] = []
    @Published var questions: [Question] = []
    
    init() {
        loadQuestions()
        sortQuestions()
    }
    
    //This function is not working as of now, but in theory it's correct.
    func loadQuestions() {
        print("loading questions...")
        guard let url = Bundle.main.url(forResource: "RawTrivia", withExtension: "json")
            else {
                print("json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let questions = try? JSONDecoder().decode([Question].self, from: data!) //potentially .self after [Question]
        
        self.questions = questions ?? []
    }
    
    func learnedQuestion(q: Question) {
        if let index = self.unknownQuestions.firstIndex(where: { $0.id == q.id }) {
            self.unknownQuestions[index].learned.toggle()
            self.knownQuestions.append(self.unknownQuestions[index])
            self.unknownQuestions.remove(at: index)
        }
    }
    
    func sortQuestions() {
        for index in 0..<questions.count {
            if questions[index].learned {
                knownQuestions.append(questions[index])
            } else {
                unknownQuestions.append(questions[index])
            }
        }
        //questions.removeAll()
        //save space? Is that necessary? Or could questions[] be used for something?
    }
}
