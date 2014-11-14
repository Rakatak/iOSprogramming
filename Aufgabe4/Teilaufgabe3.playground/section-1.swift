// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Rec {
    var x: Int
    var y: Int
}

struct Figure {
    var x1: Int
    var y1: Int
    var x2: Int
    var y2: Int
    
    var rE1: Rec  {
        get {
            return Rec(x: x1, y: y1)
        }
        set(newRec) {
            println("changed x and y")
            x2 = newRec.x - x1
            y2 = newRec.y - y1
            x1 = newRec.x
            y1 = newRec.y
            
        }
    }
    
    var rE2: Rec{
        get {
            return Rec(x: x2, y: y2)
        }
    }
}

var lol = Figure(x1:3, y1:3, x2:1, y2:1)

lol.rE1
lol.rE2

lol.rE1 = Rec(x: 2, y: 2)

lol.rE1
lol.rE2

