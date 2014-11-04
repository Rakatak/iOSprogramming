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
        
        var gameCounter = 0
        
        var robinArray = [String]()
        var jessiArray = [String]()
        
        func saveTurn (player: Bool, field: String) {
            gameCounter++
            if (player){
                println(field)
                jessiArray.append(field)
                validate(jessiArray)
            } else {
                println(field)
                robinArray.append(field)
                validate(jessiArray)
            }
        }
        
        
        func validate(array: [String]){
            
            array.count
            
            if (array.count < 3){
                return
            }
            
            if (true){
                
            
                
            } else if (gameCounter == 9){
                let alert = UIAlertView()
                alert.title = "LOL!"
                alert.message = "You both lost!"
                alert.addButtonWithTitle("Replay")
                alert.show()
            }
        }
        
        
        func winAlert(player: Bool) {
            
            if (player){
                let alert = UIAlertView()
                alert.title = "Congratulations!"
                alert.message = "Jessi wins!"
                alert.addButtonWithTitle("Replay")
                alert.show()
            } else {
                
                let alert = UIAlertView()
                alert.title = "Congratulations!"
                alert.message = "Robin Wins!"
                alert.addButtonWithTitle("Replay")
                alert.show()
            }
        }
    }
}


//                let alertController = UIAlertController(title: "Tic Tac Toe", message:
//                    "LOL, ihr habt beide verloren!", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default,handler: nil))
//
//                self.presentViewController(alertController, animated: true, completion: nil)
                