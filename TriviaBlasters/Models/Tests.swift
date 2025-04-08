//
//  Tests.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 4/8/25.
//

import Foundation
import SwiftUI

var questions: [Question] = [Question(id: 1, question: "The @main attribute (where the app begins) is found in...", answer: "...App.swift", options: ["...App.swift", "ContentView.swift", "Assets.xcassets", "PreviewContent.swift"], learned: true),
                                    Question(id: 2,
                                             question: "The default view for an Xcode project is…",
                                             answer: "ContentView.swift",
                                             options: ["ContentView.swift", "...App.swift", "PreviewContent.swift", "ViewModel.swift"],
                                             learned: false),
                                    Question(id: 3,
                                             question: "Single line comments in Swift are begun by...",
                                             answer: "//",
                                             options: ["/*", "//", "/(", "***"],
                                             learned: false),
                                    Question(id: 4,
                                             question: "True or False: The line \"let num= 2\" creates a mutable variable with the value 2.",
                                             answer: "False",
                                             options: ["True", "False"],
                                             learned: false),
                                    Question(id: 5,
                                             question: "You can print the value of the variable \"var\" by using the format...",
                                             answer: "print(“var is \\(var)”)",
                                             options: ["print(“var is \\(var)”)", "print(“var”)", "print(“var is /(var)”)", "print(“var is [var]”)"],
                                             learned: false)]
struct Test {
    
    func encodedQuestionFormatView() -> String {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(questions)
            print(String(data: data, encoding: .utf8) ?? "Error converting to string")
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Question].self, from: data)
            print(questions[4].answer)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return "Done!"
    }
}


struct TestView: View {
    
    var test = Test()
    
    var body: some View {
        Text(test.encodedQuestionFormatView())
    }
    
}

#Preview {
    TestView()
}

/*
 
 [
    {
        "id":1,
        "answer":"A",
        "learned":true,
        "question":"What is the first letter of the alphabet?",
        "options":["G","A","Omega","Z"]
    },
    {
        "id":2,
        "answer":"A",
        "learned":false,
        "question":"What is the first letter of the alphabet?",
        "options":["G","A","Omega","Z"]
    },
    {
        "id":3,
        "answer":"A",
        "learned":true,
        "question":"What is the first letter of the alphabet?",
        "options":["G","A","Omega","Z"]
    },
    {
        "id":4,
        "answer":"A",
        "learned":false,
        "question":"What is the first letter of the alphabet?",
        "options":["G","A","Omega","Z"]
    },
    {
        "id":5,
        "answer":"A",
        "learned":false,
        "question":"What is the first letter of the alphabet?",
        "options":["G","A","Omega","Z"]
    }
 ]
 
 */
