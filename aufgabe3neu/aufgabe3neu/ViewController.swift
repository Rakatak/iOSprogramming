//
//  ViewController.swift
//  Aufgabe3
//
//  Created by master on 31.10.14.
//  Copyright (c) 2014 TicTacToe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var playTurn = true
    
    var tttBrain = TTTBrain()
    let white = UIColor(red:1.0, green:0.0,blue:0.0,alpha:0.0)
    let red = UIColor(red:1.0, green:0.0,blue:0.0,alpha:0.8)
    let green = UIColor(red:0.0, green:1.0,blue:0.0,alpha:0.8)
    
    
    @IBOutlet var playButtons: [UIButton]!
    
    @IBOutlet weak var playerName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareButtons()
        
        let image = drawField()
        
        let imageSize = CGSize(width: 300, height: 300)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x:10, y: 150), size: imageSize))
        self.view.addSubview(imageView)
        
        imageView.image = image
        // Do any additional setup after loading the view, typically from a nib.
        
        playerName.text = "Jessi's"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressButton(sender: AnyObject) {
        var button = sender as UIButton
        tttBrain.saveTurn(playTurn, field: button.titleForState(UIControlState.Normal)!)
        
        if (playTurn == true){
            sender.setTitle("X", forState: UIControlState.Normal)
            sender.setTitleColor(red, forState: UIControlState.Normal)
            playTurn = false
            playerName.text = "Robin's"
            
        } else {
            sender.setTitle("O", forState: UIControlState.Normal)
            sender.setTitleColor(green, forState: UIControlState.Normal)
            playTurn = true
            playerName.text = "Jessi's"
            
        }
        button.enabled = false
        
    }
    
    @IBAction func replay(sender: AnyObject){
    }
    
    func drawField () -> UIImage {
        let offset = 10
        let opaque = false
        let imageSize = CGSize(width: 300, height: 300)
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: imageSize)
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(context, 2.0)
        
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context, CGRectGetMaxX(bounds)/4+10, CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds)/4 + 10, CGRectGetMaxY(bounds))
        
        CGContextMoveToPoint(context, (CGRectGetMaxX(bounds)/4)*3-10, CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, (CGRectGetMaxX(bounds)/4)*3-10, CGRectGetMaxY(bounds))
        
        CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMaxY(bounds)/4+10)
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds)/4+10)
        
        CGContextMoveToPoint(context, CGRectGetMinX(bounds), (CGRectGetMaxY(bounds)/4)*3-10)
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), (CGRectGetMaxY(bounds)/4)*3-10)
        
        CGContextStrokePath(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
    func prepareButtons() {
        var counter = 1
        
        for (button) in playButtons {
            button.setTitle(counter.description, forState: UIControlState.Normal)
            button.setTitleColor(white, forState: UIControlState.Normal)
            counter++
            
        }
        
    }
    
    class TTTBrain{
        
        var one = 0;
        var two = 0;
        var three = 0;
        var four = 0;
        var five = 0;
        var six = 0;
        var seven = 0;
        var eight = 0;
        
        let alert = UIAlertView()
        
        
        var gameCounter = 0
        
        var robinArray = [String]()
        var jessiArray = [String]()
        
        func saveTurn (player: Bool, field: String) {
            gameCounter++
            if (player){
                println(field)
                jessiArray.append(field)
                validate(jessiArray, player:player)
            } else {
                println(field)
                robinArray.append(field)
                validate(robinArray, player:player)
            }
        }
        
        
        func validate(array: [String], player:Bool){
            alert.delegate = ViewController()
            resetCounters()
            
            if (array.count >= 3){
                checkArray(array)
                
                if (one == 3 || two == 3 || three == 3 || four == 3 || five == 3 || six == 3 || seven == 3 || eight == 3){
                    winAlert(player)
                    
                } else if (gameCounter == 9){
                    alert.title = "LOL!"
                    alert.message = "You both lost!"
                    alert.addButtonWithTitle("Replay")
                    alert.show()
                }
            }
        }
        
        func winAlert(player: Bool) {
            alert.title = "Congratulations!"
            alert.addButtonWithTitle("Replay")
            if (player){
                alert.message = "Jessi wins!"
            } else {
                alert.message = "Robin Wins!"
            }
            alert.show()

            return
        }
        
        func checkArray(array: [String]){
            if contains(array, "1"){
                one++;
                four++;
                seven++;
            }
            if contains(array, "2"){
                three++;
                four++;
            }
            if contains(array, "3"){
                two++;
                four++;
                eight++;
            }
            if contains(array, "4"){
                one++;
                five++;
                seven++;
            }
            if contains(array, "5"){
                three++;
                five++;
                seven++;
                eight++;
            }
            if contains(array, "6"){
                two++;
                five++;
            }
            if contains(array, "7"){
                one++;
                six++;
                eight++;
            }
            if contains(array, "8"){
                three++;
                six++;
            }
            if contains(array, "9"){
                two++;
                six++;
                seven++;
            }
        }
        
        func resetCounters(){
            one = 0
            two = 0
            three = 0
            four = 0
            five = 0
            six = 0
            seven = 0
            eight = 0
        }
    }
}



//                let alertController = UIAlertController(title: "Tic Tac Toe", message:
//                    "LOL, ihr habt beide verloren!", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default,handler: nil))
//
//                self.presentViewController(alertController, animated: true, completion: nil)
