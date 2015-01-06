//
//  GameController.swift
//  GuessTheSight
//
//  Created by master on 04.01.15.
//  Copyright (c) 2015 797459. All rights reserved.
//

import Foundation

class GameController {
    
    var rightAnswer: HTMLNode!
    var wrongAnswers: [String]!
    
    init(){
        
    }
    
    func reset(){
        rightAnswer = nil
        wrongAnswers = nil
        
    }
    
    func set(rightA: HTMLNode, wrongAs: [String]){
        self.rightAnswer = rightA
        self.wrongAnswers = wrongAs
    }
    
    func validate(answer: String) -> Bool{
        return answer == rightAnswer.rawStringValue!
    }
}