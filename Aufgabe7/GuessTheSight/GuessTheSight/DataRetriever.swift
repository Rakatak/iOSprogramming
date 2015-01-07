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
//        var newUrl = NSURL(string:"http://www.berlin.de/orte/sehenswuerdigkeiten/mauergedenkstaette-brandenburger-tor/")

        println("Retrieving adress of sight on: \(newUrl!)\n")
        
        var adressDoc = HTMLDocument(contentsOfURL: newUrl!, encoding:NSUTF8StringEncoding, error: &err)!
        
//        println(adressDoc.body?.HTMLString)
        
        return misc(adressDoc, sight: node)
        
    }
    
    func misc(adressDoc: HTMLDocument, sight: HTMLNode) -> String {
        
        var zipBool = false
        var cityBool = false
        var streetBool = false
        
        var zip = String()
        var city = String()
        var street = String()
        
        while streetBool == false || zipBool == false{
            println("-----Gathering Adresses-----\n")
            
//            if cityBool == false {
//                println("getting City")
//                var cityNode = adressDoc.body?.descendantsWithClass("locality")
//                if cityNode?.count != 0 {
//                    city = cityNode![0].rawTextContent!
//                    cityBool = true
//                }
//            }
            
            
            if streetBool == false {
                var streetNode = adressDoc.body?.descendantsWithClass("street-address")
                if streetNode?.count != nil {
                    street = streetNode![0].rawTextContent!
                    streetBool = true
                }
            }
            
            if zipBool == false {
                println("getting Postal Code")
                var zipNode = adressDoc.body?.descendantsWithClass("postal-code")
                if zipNode?.count != 0 {
                    zip = zipNode![0].rawTextContent!
                    zipBool = true
                }
            }
            
            
        }
        
        var adress = "\(street), Berlin, \(zip)"
        println(adress)
        return adress
    }
    
    
    
  
}
