//
//  TTTBrain.swift
//  aufgabe3neu
//
//  Created by master on 31.10.14.
//  Copyright (c) 2014 TicTacToe. All rights reserved.
//

import Foundation

class TTTBrain{
    
    var one = 0;
    var two = 0;
    var three = 0;
    var four = 0;
    var five = 0;
    var six = 0;
    var seven = 0;
    var eight = 0;
    
    var gameCounter = 0
    
    var robinArray = [String]()
    var jessiArray = [String]()
    
    func saveTurn (player: Bool, field: String) -> String{
        gameCounter++
        if (player){
            println(field)
            jessiArray.append(field)
            return validate(jessiArray, player:player)
        } else {
            println(field)
            robinArray.append(field)
            return validate(robinArray, player:player)
        }
    }
    
    
    func validate(array: [String], player:Bool) -> String{
        resetCounters()
        
        if (array.count >= 3){
            checkArray(array)
            
            if (one == 3 || two == 3 || three == 3 || four == 3 || five == 3 || six == 3 || seven == 3 || eight == 3){
                gameCounter = 0
                robinArray.removeAll(keepCapacity: true)
                jessiArray.removeAll(keepCapacity: true)
                if player{
                    return "Jessi"
                } else {
                    return "Robin"
                }
            } else if (gameCounter == 9){
                gameCounter = 0
                robinArray.removeAll(keepCapacity: true)
                jessiArray.removeAll(keepCapacity: true)
                return "LOL"
            }
        }
        return "none"
    }
    
    
    
    func checkArray(array: [String]){
        if contains(array, "1"){
            one++;
            four++;
            seven++;
        }
        if contains(array, "2"){
            three++;
            four++;
        }
        if contains(array, "3"){
            two++;
            four++;
            eight++;
        }
        if contains(array, "4"){
            one++;
            five++;
        }
        if contains(array, "5"){
            three++;
            five++;
            seven++;
            eight++;
        }
        if contains(array, "6"){
            two++;
            five++;
        }
        if contains(array, "7"){
            one++;
            six++;
            eight++;
        }
        if contains(array, "8"){
            three++;
            six++;
        }
        if contains(array, "9"){
            two++;
            six++;
            seven++;
        }
    }
    
    func resetCounters(){
        one = 0
        two = 0
        three = 0
        four = 0
        five = 0
        six = 0
        seven = 0
        eight = 0
    }
}