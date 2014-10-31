//
//  ViewController.swift
//  Aufgabe3
//
//  Created by master on 31.10.14.
//  Copyright (c) 2014 TicTacToe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = drawField()
        
        let imageSize = CGSize(width: 300, height: 300)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x:10, y: 135), size: imageSize))
        self.view.addSubview(imageView)
        
        imageView.image = image
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}

