// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol Log {
    func logMe(msg: String) -> String
}


struct Loger {
    var delegate: Log
    func loge(msg: String) -> () {
        println("Logging: " + self.delegate.logMe(msg))
    }
}


struct U2fan: Log {
    func logMe(msg: String) -> String {
        if msg.lowercaseString.rangeOfString("u2") != nil{
            return "I love how every song sounds the same"
        } else {
            return ""
        }
    }
}

struct MJfan: Log {
    func logMe(msg: String) -> String {
        if msg.lowercaseString.rangeOfString("keep on") != nil{
            return "Let the force don't stop, don't stop till you get enough"
        } else {
            return ""
        }
    }
}

struct KoLfan: Log {
    func logMe(msg: String) -> String {
        if msg.lowercaseString.rangeOfString("red morning light") != nil{
            return "you're giving all your cinnamon away!"
        } else {
            return ""
        }
    }
}

var u2Fan = U2fan()
var mjFan = MJfan()
var kolFan = KoLfan()

var logManager = Loger(delegate: u2Fan)

logManager.loge("u2")
logManager.loge("Bono")

logManager.delegate = mjFan

logManager.loge("Keep on")
logManager.loge("Michael")

logManager.delegate = kolFan

logManager.loge("red morning light")
logManager.loge("Caleb")



