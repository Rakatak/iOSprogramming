//
//  ViewController.swift
//  Aufgabe3
//
//  Created by master on 31.10.14.
//  Copyright (c) 2014 TicTacToe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    
    var playTurn = true
    var tttBrain = TTTBrain()
    var alertView = UIAlertView()
    
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
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        println("Start new Game!")
        prepareButtons()
        
    }
    
    @IBAction func pressButton(sender: AnyObject) {
        var button = sender as UIButton
        var msg = tttBrain.saveTurn(playTurn, field: button.titleForState(UIControlState.Normal)!)
        
        if (msg == "Robin" || msg == "Jessi"){
            winAlert(msg, alert: alertView)
        } else if msg == "LOL"{
            winAlert(msg, alert: alertView)
        }
        
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
            button.enabled = true
            button.setTitle(counter.description, forState: UIControlState.Normal)
            button.setTitleColor(white, forState: UIControlState.Normal)
            counter++
        }
    }
    
    func winAlert(player: String, alert: UIAlertView) {
        alert.delegate = self
        alert.title = "Congratulations!"
        alert.addButtonWithTitle("Replay")
        alert.message = player + " wins!"
        alert.show()
    }
    
    func drawAlert(player: String, alert: UIAlertView) {
        alert.delegate = self
        alert.title = "LOL!"
        alert.addButtonWithTitle("Replay")
        alert.message = "You both lost!"
        alert.show()
    }
    
    
}