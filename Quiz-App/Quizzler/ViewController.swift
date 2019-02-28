//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let allQuastions = QuestionBank()
    var pickedAnswer : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuastions.list[0]            // make first question
        questionLabel.text = firstQuestion.questionText     // display first question
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        print(sender.tag)
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
    }
    
    
    func updateUI() {
      
    }
    

    func nextQuestion() {
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuastions.list[0].answer
        if correctAnswer == pickedAnswer{
            print("You got it!")
        }
        else{
            print("wrong")
        }
        
    }
    
    
    func startOver() {
       
    }
    

    
}
