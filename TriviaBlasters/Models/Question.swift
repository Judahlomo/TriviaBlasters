//
//  Question.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import Foundation

struct Question: Identifiable, Decodable, Hashable {
    var id = UUID()
    var question: String
    var answer: String
    var options: [String]
    var learned: Bool = false
    //var difficulty: String //can be "easy", "medium", or "hard"
    //This would be something to have happen later when more complexity is desired
    
    enum CodingKeys: CodingKey {
        case question
        case answer
        case options
        case learned
        //case difficulty
    }
}
