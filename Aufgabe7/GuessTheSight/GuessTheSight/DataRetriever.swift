//
//  DataRetriever.swift
//  GuessTheSight
//
//  Created by Rakatak alias Robin Steller on 03.01.15.
//  Copyright (c) 2015 797459. All rights reserved.
//

import Foundation
import CoreLocation

class DataRetriever {
    
    let url = NSURL(string:"http://www.berlin.de/orte/sehenswuerdigkeiten/az/#A")

    var err : NSError?
    
    var totalArray = [HTMLNode]()
    
    init(){
    }
    
    
    func retrieveAllSights() -> Array<HTMLNode> {
        println("*************************************************************")
        println("*********************  Retrieving data  *********************\n\nFrom: \(url!)\n")
        
        var doc = HTMLDocument(contentsOfURL: url!, encoding:NSUTF8StringEncoding, error: &err)
        var oddArray = doc?.body?.descendantsWithClass("odd")
        var evenArray = doc?.body?.descendantsWithClass("even")

        let oddLimit = oddArray?.endIndex
        let evenLimit = evenArray?.endIndex
        
        //retrieve all the even Rows of Sights
        for var i = 0; i < evenLimit! - 8; i++ {
            if let sight = evenArray![i].childOfTag("a"){
                totalArray.append(sight)
            }
        }
        
        //retrieve all the odd Rows of Sights
        for var i = 0; i < oddLimit! - 11; i++ {
            if let sight = oddArray![i].childOfTag("a"){
                totalArray.append(sight)
            }
        }
        
        println("Data retrieved")
        println("Count of total sights after filtering: \(totalArray.count)\n")
        println("*************************************************************\n\n")

        return totalArray
    }
    
    func randomChoiceRight() -> HTMLNode {
        
        println("-------------------------------------------------")
        
        var length = UInt32(totalArray.count - 1)
        var randomNumber = Int(arc4random_uniform(length))
        var exArray = prepExArray()
        var rightBool = false
        
        while rightBool == false{
            for (index, elem) in enumerate(exArray) {
                if randomNumber == elem{
                    rightBool = false
                    randomNumber = Int(arc4random_uniform(length))
                    continue
                } else {
                    if index == exArray.count - 1 {
                        rightBool = true
                    }
                }
                continue
            }
            
        }
        
        println("Random Sight chosen at Index at: \(randomNumber) ")
        println("\(totalArray[randomNumber].rawTextContent!)\n")
        
        var node = totalArray[randomNumber]
        totalArray.removeAtIndex(randomNumber)
        return node
        
    }
    
    func randomChoiceWrong() -> [String] {
        
        var wrongAnswersArray = [String]()
        
        for var i = 0; i < 3; i++ {
            
            var length = UInt32(totalArray.count - 1)
            var randomNumber = Int(arc4random_uniform(length))
            
            wrongAnswersArray.append(totalArray[randomNumber].rawTextContent!)
            
            println("Random wrong Sight chosen at Index at: \(randomNumber)")
            println("\(totalArray[randomNumber].rawTextContent!)\n")
            
        }
        
        println("-------------------------------------------------\n")

        return wrongAnswersArray
    }
    
    func getAdress(node: HTMLNode) -> String {
        
        var newUrl = NSURL(string:"http://www.berlin.de" + node.hrefValue!)

        println("Retrieving adress of sight on: \(newUrl!)\n")
        
        var adressDoc = HTMLDocument(contentsOfURL: newUrl!, encoding:NSUTF8StringEncoding, error: &err)!
        
        
        return misc(adressDoc, sight: node)
        
    }
    
    func misc(adressDoc: HTMLDocument, sight: HTMLNode) -> String {
        
        var zipBool = false
        var streetBool = false
        
        var zip = String()
        var street = String()
        
        print("Gathering Adress : ")
        while streetBool == false || zipBool == false{
            print("-")
            if streetBool == false {
                var streetNode = adressDoc.body?.descendantsWithClass("street-address")
                if streetNode?.count != nil {
                    street = streetNode![0].rawTextContent!
                    streetBool = true
                }
            }
            
            if zipBool == false {
                var zipNode = adressDoc.body?.descendantsWithClass("postal-code")
                if zipNode?.count != 0 {
                    zip = zipNode![0].rawTextContent!
                    zipBool = true
                }
            }
            
        }
        
        var adress = "\(street), Berlin, \(zip)"
        println("\n\nRetrieved following Adress: \(adress)\n")
        return adress
    }
    
    
    func prepExArray() -> [Int] {
        var array = [Int]()
        array.append(24)
        array.append(35)
        array.append(44)
        array.append(66)
        array.append(87)
        array.append(88)
        array.append(94)
        array.append(95)
        array.append(96)
        array.append(99)
        array.append(115)
        array.append(126)
        array.append(150)
        array.append(152)
        array.append(159)
        array.append(160)
        array.append(162)
        array.append(172)
        array.append(173)
        array.append(175)
        array.append(176)
        array.append(182)
        array.append(194)
        array.append(230)
        array.append(231)
        array.append(233)
        array.append(235)
        array.append(244)
        array.append(245)
        array.append(267)

        return array
        
    }
    
    
  
}
