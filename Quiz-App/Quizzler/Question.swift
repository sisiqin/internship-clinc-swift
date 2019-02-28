//
//  Question.swift
//  Quizzler
//
//  Created by Xi Qin on 02/13/19.
//  Copyright © 2019 Xi Qin. All rights reserved.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    
    // initializer "init" is like a constructor
    init(text: String, correctAnswer: Bool){
        questionText = text
        answer = correctAnswer
    }
}
