//
//  DataRetriever.swift
//  GuessTheSight
//
//  Created by master on 03.01.15.
//  Copyright (c) 2015 797459. All rights reserved.
//

import Foundation

class DataRetriever {
    
    let url = NSURL(string:"http://www.berlin.de/orte/sehenswuerdigkeiten/az/#A")

    var err : NSError?
    
    
    func retrieveAllSights() -> Array<HTMLNode> {
        var doc = HTMLDocument(contentsOfURL: url!, encoding:NSUTF8StringEncoding, error: &err)

        var oddArray = doc?.body?.descendantsWithClass("odd")
        var evenArray = doc?.body?.descendantsWithClass("even")

        println(nodeArray?.count)

        let limit = nodeArray?.endIndex
        
        for var i = 0; i < limit! - 11; i++ {
            if let sight = nodeArray?[i].childOfTag("a")?.rawTextContent {
                println(sight)
                
            }
            
        }
        return nodeArray!
    }
    
  
}
