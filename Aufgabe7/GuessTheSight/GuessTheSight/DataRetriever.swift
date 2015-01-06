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
            if let sight = evenArray?[i].childOfTag("a")?{
                totalArray.append(sight)
            }
        }
        
        //retrieve all the odd Rows of Sights
        for var i = 0; i < oddLimit! - 11; i++ {
            if let sight = oddArray?[i].childOfTag("a")?{
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
        
//        var newUrl = NSURL(string:"http://www.berlin.de" + node.hrefValue!)
        var newUrl = NSURL(string:"http://www.berlin.de/orte/sehenswuerdigkeiten/mauergedenkstaette-brandenburger-tor/")

        println("Retrieving adress of sight on: \(newUrl!)")
        
        var adressDoc = HTMLDocument(contentsOfURL: newUrl!, encoding:NSUTF8StringEncoding, error: &err)!
        
        
    
       
        
        
        
        return misc(adressDoc)
        
    }
    
    func misc(adressDoc: HTMLDocument) -> String {
        
        var zipBool = false
        var cityBool = false
        var streetBool = false
        
        var zip = String()
        var city = String()
        var street = String()
        
        while zipBool == false || cityBool == false || streetBool == false {
            
            var streetNode = adressDoc.body?.descendantsWithClass("street-adress")
            var zipNode = adressDoc.body?.descendantsWithClass("postal-code")
            var cityNode = adressDoc.body?.descendantsWithClass("locality")
            
            if streetNode?.count != 0 {
                
            }
            
            if zipNode?.count != 0 {
                
            }
            
            if cityNode?.count != 0 {
                
            }
        }
        
        var adress = "\(street) ,\(zip) , \(city)"
        println(adress)

        return adress
    }
    
    func getLocationCoords(adress: String) -> [Double] {
        
        var geoCoder = CLGeocoder()
        var latlong = [Double]()
        
        geoCoder.geocodeAddressString(adress, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error while Geocoding")
            } else {
                println("Getting lat and lon values")
                var placemark: CLPlacemark = placemarks[0] as CLPlacemark
                latlong.append(Double(placemark.location.coordinate.latitude))
                latlong.append(Double(placemark.location.coordinate.longitude))
                
            }
        })
        return latlong
    }
    
    
  
}
