//
//  Question.swift
//  TriviaBlasters
//
//  Created by Troast, Graham on 3/7/25.
//

import Foundation

struct Question: Decodable, Hashable, Encodable, Identifiable { //No Identifiable in here, which requires an ID
    var id: Int
    var question: String
    var answer: String
    var options: [String]
    var learned: Bool = false
    //var difficulty: String //can be "easy", "medium", or "hard"
    //This would be something to have happen later when more complexity is desired
    
    enum CodingKeys: CodingKey {
        case id
        case question
        case answer
        case options
        case learned
        //case difficulty
    }
}
