//
//  TriviaQuestionsModel.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import Foundation

class TriviaQuestionsModel: ObservableObject {
    @Published var questions: [Question] = [] {
        didSet {
            saveQuestions()
        }
    }
    
    init() {
        loadQuestions()
    }
    
    //Loads questions from RawTrivia json file. Handles errors by printing out localizedDescription
    func loadQuestions() {
        do {
            
            let url = Bundle.main.url(forResource: "RawTrivia", withExtension: "json")
            
            let data = try Data(contentsOf: url!)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            
            self.questions = questions
        } catch {
            print("Error loading questions: \(error.localizedDescription)")
        }
    }
    
    //Toggles a question's learned variable to true. Saves questions afterwards
    func learnedQuestion(q: Question) {
        if let index = self.questions.firstIndex(where: { $0.id == q.id }) {
            self.questions[index].learned = true //could do .toggle()
        }
        saveQuestions()
    }
    
    func learnedQuestion(q: Int) {
        self.questions[q].learned = true //could do .toggle()
        saveQuestions()
    }
    
    func randomQuestion() -> Question {
        let index = Int.random(in: 0..<self.questions.count)
        return self.questions[index]
    }
    
    //Saves questions. Handles errors by printing out localizedDescription
    func saveQuestions() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(questions)
            let url = Bundle.main.url(forResource: "RawTrivia", withExtension: "json")
            try data.write(to: url!)
        } catch {
            print("Error saving questions: \(error.localizedDescription)")
        }
    }
    
}
