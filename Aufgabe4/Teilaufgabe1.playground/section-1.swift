// Playground - noun: a place where people can play

import Foundation

enum VehicleClass {
    case PKW(serial: String)
    case LKW(serial: String, axis: Int, weight: Int)
}

println("Hello Test")

var honda = VehicleClass.PKW(serial: "ISAMEN76UHW6")
var toyota = VehicleClass.PKW(serial: "IWBABA76UHW6")
var daewoo = VehicleClass.PKW(serial: "USIAHF")


var dodge = VehicleClass.LKW(serial: "ISAMEN76UHW6", axis: 4, weight: 70)
var ford = VehicleClass.LKW(serial: "8SUEB344", axis: 1, weight: 10)
var volvo = VehicleClass.LKW(serial: "VCBE63HJ90SK", axis: 4, weight: 8)


func plausibilityTest(vehicle: VehicleClass) -> String {
    
    switch vehicle {
    case var .PKW(serial):
        if (serial.serial.lowercaseString.rangeOfString("wbaba") != nil || countElements(serial.serial) != 12) {
            return "That is not a valid car!"
        }
        return "It's a real car!"
        
    case var .LKW(serial, axis, weight):
        if (countElements(serial) != 12) {
            return "That is not a valid truck, something's wrong with the serial!"
        }
        if (weight/axis > 2){
            return "Trucks' maximum weight exceeded!"
        }
        return "It's a real truck!"
        
    }
}

plausibilityTest(honda)
plausibilityTest(toyota)
plausibilityTest(daewoo)

plausibilityTest(volvo)
plausibilityTest(ford)
plausibilityTest(dodge)
