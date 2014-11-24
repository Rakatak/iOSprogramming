// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Rec {
    var x: Int
    var y: Int
    var size: (Int, Int)
}

struct Figure {
    var rec1: Rec {
        willSet(newRec) {
            rec2.x += newRec.x - rec1.x
            rec2.y += newRec.y - rec1.y
        }
    }
    var rec2: Rec
}

var no1 = Rec(x: 1, y: 1, size: (2, 2))
var no2 = Rec(x: 10, y: 10, size: (22, 22))

var figure = Figure(rec1: no1, rec2: no2)

figure.rec1 = Rec(x: 90, y: 1, size: (2, 2))
figure.rec2



