//
//  QuestionModel.swift
//  ScrambledWords
//
//  Created by Aditya Karki on 9/24/25.
//

import Foundation

struct Question {
    let image: String
    var scrambledLetters: [Letter]
    let answer: String
}

// MARK: - Generate Questions
extension Question {
    static func generateQuestions() -> [Question] {
        return [
            Question(image: "orange", scrambledLetters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "O"),
                Letter(id: 2, text: "E"),
                Letter(id: 3, text: "R"),
                Letter(id: 4, text: "N"),
                Letter(id: 5, text: "G")
            ], answer: "ORANGE"),
            Question(image: "banana", scrambledLetters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "A"),
                Letter(id: 2, text: "N"),
                Letter(id: 3, text: "A"),
                Letter(id: 4, text: "B"),
                Letter(id: 5, text: "N")
            ], answer: "BANANA"),
            Question(image: "apple", scrambledLetters: [
                Letter(id: 0, text: "P"),
                Letter(id: 1, text: "A"),
                Letter(id: 2, text: "P"),
                Letter(id: 3, text: "E"),
                Letter(id: 4, text: "L"),
            ], answer: "APPLE")
        ]

    }
}
