//
//  ViewController.swift
//  aufgabe2
//
//  Created by s797459 s797459 on 17.10.14.
//  Copyright (c) 2014 s797459. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var digitsResult: UILabel!
    
    @IBOutlet weak var digitsInput: UILabel!
    
    var currentDigit = ""
    
    var previousDigit = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        digitsInput.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func digitButton(sender: AnyObject) {
        println("Digit")
        currentDigit = digitsInput.text!
        var digit = sender.currentTitle
        var finalDigit = currentDigit.stringByAppendingString(digit!!)
        digitsInput.text = finalDigit
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        if (previousDigit.isEmpty || digitsInput.text!.isEmpty){
           println("enter additional number first")
        } else {
            currentDigit = digitsInput.text!
            var currentDig = String(currentDigit).toInt()
            var previousDig =  String(previousDigit).toInt()
            var finalRes = currentDig! + previousDig!
            previousDigit = String(finalRes)
            digitsInput.text = ""
            currentDigit = ""
            digitsResult.text = previousDigit

        }

    }

    @IBAction func subtract(sender: AnyObject) {
        if (previousDigit.isEmpty || digitsInput.text!.isEmpty){
            println("enter additional number first")
        } else {
            currentDigit = digitsInput.text!
            var currentDig = String(currentDigit).toInt()
            var previousDig =  String(previousDigit).toInt()
            var finalRes = previousDig! - currentDig!
            previousDigit = String(finalRes)
            digitsInput.text = ""
            currentDigit = ""
            digitsResult.text = previousDigit
            
        }

    }
    
    @IBAction func multiplyButton(sender: AnyObject) {
        
        if (previousDigit.isEmpty || digitsInput.text!.isEmpty){
            println("enter additional number first")
        } else {
            currentDigit = digitsInput.text!
            var currentDig = String(currentDigit).toInt()
            var previousDig =  String(previousDigit).toInt()
            var finalRes = previousDig! * currentDig!
            previousDigit = String(finalRes)
            digitsInput.text = ""
            currentDigit = ""
            digitsResult.text = previousDigit
            
        }

    }
    
    @IBAction func divideButton(sender: AnyObject) {
        
        if (previousDigit.isEmpty || digitsInput.text!.isEmpty){
            println("enter additional number first")
        } else {
            currentDigit = digitsInput.text!
            var currentDig = String(currentDigit).toInt()
            var previousDig =  String(previousDigit).toInt()
            var finalRes = previousDig! * currentDig!
            previousDigit = String(finalRes)
            digitsInput.text = ""
            currentDigit = ""
            digitsResult.text = previousDigit
            
        }

    }
    
    @IBAction func enterButton(sender: AnyObject) {
        if (previousDigit.isEmpty){
            previousDigit = currentDigit
            currentDigit = ""
            digitsInput.text = ""

        } else {
            digitsResult.text = previousDigit
            println("not available")
        }
        
        
    }
    
}

