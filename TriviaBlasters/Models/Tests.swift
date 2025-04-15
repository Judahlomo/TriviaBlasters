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
                                             learned: false),
                                    Question(id: 6,
                                             question: "True or False: Swift can infer the type of variables if they are initialized without an explicitly type declaration.",
                                             answer: "True",
                                             options: ["True", "False"],
                                             learned: false),
                                    Question(id: 7,
                                             question: "A ___-while loop completes one iteration before checking the terminating condition.",
                                             answer: "repeat",
                                             options: ["repeat", "do", "for", "run"],
                                             learned: false),
                                    Question(id: 8,
                                             question: "Which one of these is not a control-flow keyword for switch statements?",
                                             answer: "repeat",
                                             options: ["repeat", "continue", "break", "fallthrough"],
                                             learned: false),
                                    Question(id: 9,
                                             question: "True or False: Cases in switch statements fall through to the next case unless they end with a break statement, like in Java or C.",
                                             answer: "False",
                                             options: ["True", "False"],
                                             learned: false),
                                    Question(id: 10,
                                             question: "Guard statements are used for...",
                                             answer: "Early exits if a condition is not met",
                                             options: ["Early exits if a condition is not met", "An alternative to the if-then-else structure", "Protecting a variable from being modified", "Escorting the princess to safety"],
                                             learned: false),
                                    Question(id: 11,
                                             question: "The syntax for specifying a return type for a function is...",
                                             answer: "func getName() -> String {...}",
                                             options: ["func getName() -> String {...}", "func String getName() {...}", "func getName() {...} -> String", "func getName() {...}.returns(String)"],
                                             learned: false),
                                    Question(id: 12,
                                             question: "Choose the proper format for assigning data values in the declaration of a struct.",
                                             answer: "Person(name: \"John\")",
                                             options: ["Person(name: \"John\")", "Person(name = \"John\")", "Person(name -> \"John\")", "Person(name is \"John\")"],
                                             learned: false),
                                    Question(id: 13,
                                             question: "Structs in Swift are passed by...",
                                             answer: "Value",
                                             options: ["Value", "Reference"],
                                             learned: false),
                                    Question(id: 14,
                                             question: "The setter function on a computed property is triggered when...",
                                             answer: "A value is assigned to that property",
                                             options: ["A value is assigned to that property", "The setter function is explicitly called in the program", "The getter function is unavailable", "Defining an array of computed properties"],
                                             learned: false)]
struct Test {
    
    func encodedQuestionFormatView() -> String {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(questions)
            print(String(data: data, encoding: .utf8) ?? "Error converting to string")
            print("\n")
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Question].self, from: data)
            print(questions[4].answer)
            print(questions[4].options[0])
            print(questions[4].options[1])
            print(questions[4].options[2])
            print(questions[4].options[3])
            print(questions[3].question)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return "Done!"
    }
    
    func encodeDecodeQuestions(qs: [Question]) -> [Question] {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(questions)
            print(String(data: data, encoding: .utf8) ?? "Error converting to string")
            print("\n")
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Question].self, from: data)
            return questions
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}


struct TestView: View {
    
    var test = Test()
    
    var body: some View {
        Text(test.encodedQuestionFormatView())
        
        List {
            ForEach(test.encodeDecodeQuestions(qs: questions)) { question in
                QuestionListView(question: question)
            }
        }
        
    }
    
}

struct QuestionListView: View {
    var question: Question
    
    var body: some View {
        HStack {
            VStack {
                Text(question.question)
                    .font(.caption)
                Text(question.answer)
                    .font(.caption)
            }
            VStack {
                ForEach(0..<question.options.count) {index in
                    Text(question.options[index])
                        .font(.caption2)
                }
            }
        }
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
