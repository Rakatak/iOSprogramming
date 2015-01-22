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
    var rightAnswers: Double!
    var totalAnswers: Double!
    var adress : String!
    
    init(){
        rightAnswers = 0.0
        totalAnswers = 0.0
    }
    
    func reset(){
        rightAnswer = nil
        wrongAnswers = nil
        adress = nil
    }
    
    func set(rightA: HTMLNode, wrongAs: [String]){
        self.rightAnswer = rightA
        self.wrongAnswers = wrongAs
    }
    
    func setAddress(address: String){
        self.adress = address
    }
    
    
    func validate(answer: String) -> Bool{
        return answer == rightAnswer.rawStringValue!
    }
}