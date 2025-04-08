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
//        guard let url = Bundle.main.url(forResource: "RawTrivia", withExtension: "json")
//            else {
//                print("json file not found")
//                return
//            }
        do {
//            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let url = documentsDirectory.appendingPathComponent("RawTrivia.json")
            
            let url = Bundle.main.url(forResource: "RawTrivia", withExtension: "json")
            
            
            //let url = URL(string: "/Users/gtroast/Documents/TriviaBlasters/TriviaBlasters/Models/RawTrivia.json")
            
            print("Url: \(String(describing: url))")
            
            let data = try Data(contentsOf: url!)
            print("Got some data")
            print(String(data: data, encoding: .utf8) ?? "Error converting to string")
            let questions = try JSONDecoder().decode([Question].self, from: data) //potentially .self after [Question]
            print("Decoded array of Question elements from data")
            
            self.questions = questions
            print("Stored array in self.questions")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
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
