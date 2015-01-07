//
//  ViewController.swift
//  GuessTheSight
//
//  Created by master on 02.01.15.
//  Copyright (c) 2015 797459. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation


class ViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var retriever : DataRetriever!
    var gameController: GameController!
    var locationManager = CLLocationManager()
    var randomNumberId : Int!
    var geoCoder : CLGeocoder!
    var latlong = [Double]()
    var poi : Waypoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.hidden = true
        self.mapView.delegate = self
        geoCoder = CLGeocoder()
        
        for button in answerButtons {
            button.hidden = true
        }
        
//        var timer = NSTimer.scheduledTimerWithTimeInterval(3 , target: self, selector: Selector("retrieveData"), userInfo: nil, repeats: false)
        retrieveData()
    }
    
    func retrieveData(){
        retriever = DataRetriever()
        retriever.retrieveAllSights()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartGame(sender: UIButton) {
        
        println("-------------------  Starting Game first Time  -------------------\n")
        prepareGame()

        sleep(1)

        self.view.backgroundColor = UIColor.whiteColor()
        startButton.hidden = true
        startButton.enabled = false
        mapView.hidden = false
        
        

        
    }

    @IBAction func pressAnswer(sender: UIButton) {
        var answer = sender.titleForState(UIControlState.Normal)!
        
        println("Button pressed: \(answer)\n")
        
        if gameController.validate(answer) {
            println("Right Answer was Selected\n")
            println("-------------------------------------------------\n")

            answerButtons[randomNumberId].setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            
        } else {
            println("Wrong Answer was Selected\n")
            println("-------------------------------------------------\n")
            
            answerButtons[randomNumberId].setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        }
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("prepareGame"), userInfo: nil, repeats: false)
        
    }
    
    func prepareGame(){
        if poi != nil {
            self.mapView.removeAnnotation(poi)
        }
        
        println("\nPrepare new round")
        gameController = GameController()
        
        //Setting the button with the right answer
        randomNumberId = Int(arc4random_uniform(4))
        gameController.set(retriever.randomChoiceRight(), wrongAs: retriever.randomChoiceWrong())
        answerButtons[randomNumberId].setTitle(gameController.rightAnswer.rawTextContent!, forState: UIControlState.Normal)
        
        //Setting Buttons for wrong answers
        var gi = 0
        for var i = 0 ; i < 4; i++ {
            if i != randomNumberId {
                answerButtons[i].setTitle(gameController.wrongAnswers[gi], forState: UIControlState.Normal)
                gi++
            }
        }
        
        for button in answerButtons{
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.hidden = false
            button.enabled = true
        }
        
        prepareMap()
    }
    
    func prepareMap(){
        var answer = gameController.rightAnswer
        
        var address = retriever.getAdress(answer)
        
        var geoCoder = CLGeocoder()
        var latlong = [Double]()
        
        geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) -> Void in
            
            println("Getting lat and lon values")
            var placemark: CLPlacemark = placemarks[0] as CLPlacemark
            latlong.append(Double(placemark.location.coordinate.latitude))
            latlong.append(Double(placemark.location.coordinate.longitude))
            println("Latitude: \(latlong[0])  Longitude: \(latlong[1])")
            self.poi = Waypoint()
            self.poi.coordinate = CLLocationCoordinate2DMake(latlong[0], latlong[1])
            self.mapView.addAnnotation(self.poi)
            self.mapView.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(latlong[0] ,latlong[1]) , 1000, 1000)
            
        })
    }
}

