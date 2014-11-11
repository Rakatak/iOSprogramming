 // Playground - noun: a place where people can play

import Foundation

class Employee {
    var firstName: String
    var lastName: String
    var employeeID: Int
    var employDate: Int
    var workingHours: Int
    lazy var salary = Double()
    class var hourlyPay: Double {
        return 7.99
    }
    
    init(firstName: String, lastName: String, employeeID: Int, employDate: Int, workingHours: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.employeeID = employeeID
        self.employDate = employDate
        self.workingHours = workingHours
        self.salary = Double(workingHours) * myHourlyPay
    }
    
    var years: Int {
        get {
            return 2014 - employDate
        }
    }
    
    var myHourlyPay: Double {
        get {
            return Employee.hourlyPay + Double(years)*0.75
        }
    }
    
    func showSalary(){
        println("\(salary)€")
    }
}

println("Hello Test")



var brianFury = Employee(firstName: "Brian", lastName: "Fury", employeeID: 77, employDate: 1999, workingHours: 20)
var leiWulong = Employee(firstName: "Lei", lastName: "Wulong", employeeID: 231, employDate: 1976, workingHours: 40)
var uweBoll = Employee(firstName: "Uwe", lastName: "Boll", employeeID: 1, employDate: 2002, workingHours: 8)

println(leiWulong.salary)
println(uweBoll.salary)
println(brianFury.salary)

brianFury.showSalary()

println(leiWulong.myHourlyPay)
