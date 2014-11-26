//
//  ViewController.swift
//  Aufgabe6
//
//  Created by master on 23.11.14.
//  Copyright (c) 2014 797459. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var stations: [UIButton]!
    var locationManager = CLLocationManager()
    var stationLocations = [Double, Double, String]()
    
    @IBOutlet weak var activity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLocations()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager:CLLocationManager,
        didUpdateLocations locations:[AnyObject])
    {
        
        var loc = locations.last as CLLocation
        
//        var latValue = Double(loc.coordinate.latitude)
//        var lonValue = loc.coordinate.longitude
//        println("**** from locations:")
//        println("LAT:" + latValue.description + "    LON:" + lonValue.description)
        
//        println("**** from locationManager:")
        var latValue =  Double(locationManager.location.coordinate.latitude)
        var lonValue = Double(locationManager.location.coordinate.longitude)
        println("LAT:" + latValue.description + "    LON:" + lonValue.description)
        var curPos = (latValue, lonValue)
        
        for (index, locs) in enumerate(stationLocations) {
            stationReached(index, stationPos: locs, currentPos: loc)
        }
        
    }
    
    func stationReached(index: Int, stationPos: (Double, Double, String), currentPos: CLLocation) {

        var (lat, lon, msg) = stationPos
        var stationLoc = CLLocation(latitude: lat , longitude: lon)
        if (stationLoc.distanceFromLocation(currentPos) <= 20 ){
            println("Zu Erledigen: " + msg)
            stations[index].backgroundColor = UIColor.redColor()
            activity.text = msg
        }
        
    }
    
    func prepareLocations(){
        stationLocations.append(52.506493 , 13.332582, "Zeitung kaufen")
        stationLocations.append(52.505546 , 13.332595, "Beten gehen")
        stationLocations.append(52.503706 , 13.346214, "Emma grüßen")
        stationLocations.append(52.517792 , 13.372954, "Cool sein")
        stationLocations.append(52.518118 , 13.380085, "Hund streicheln")
        stationLocations.append(52.516682 , 13.387436, "Blumen holen")
        stationLocations.append(52.519574 , 13.403986, "Eis essen")
        stationLocations.append(52.520458 , 13.405418, "Hundefutter kaufen")
        stationLocations.append(52.518000 , 13.374486, "Fahrrad checken lassen")
        stationLocations.append(52.517344 , 13.366505, "Post abgeben")
        stationLocations.append(52.506560 , 13.351831, "Zigaretten kaufen")
        stationLocations.append(52.504608 , 13.343148, "Nach Hause fahren")
    }
    
}

