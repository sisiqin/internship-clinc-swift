//
//  Question.swift
//  Quizzler
//
//  Created by shiMac on 6/25/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
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
