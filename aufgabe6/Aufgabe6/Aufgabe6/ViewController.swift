//
//  ViewController.swift
//  Aufgabe6
//
//  Created by master on 23.11.14.
//  Copyright (c) 2014 797459. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet var stations: [UIButton]!

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var stationLocations = [Double, Double, String, String]()
    
    @IBOutlet weak var activity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLocations()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager:CLLocationManager,
        didUpdateLocations locations:[AnyObject])
    {
        
        var loc = locations.last as CLLocation
        var latValue =  Double(locationManager.location.coordinate.latitude)
        var lonValue = Double(locationManager.location.coordinate.longitude)
        println("LAT:" + latValue.description + "    LON:" + lonValue.description)
        var curPos = (latValue, lonValue)
        
        for (index, locs) in enumerate(stationLocations) {
            stationReached(index, stationPos: locs, currentPos: loc)
        }
        
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let currentLocation = userLocation.location.coordinate
        self.mapView.region = MKCoordinateRegionMakeWithDistance(currentLocation, 1000, 1000)
    }
    
    func stationReached(index: Int, stationPos: (Double, Double, String, String), currentPos: CLLocation) {

        var (lat, lon, msg, desc) = stationPos
        var stationLoc = CLLocation(latitude: lat , longitude: lon)
        if (stationLoc.distanceFromLocation(currentPos) <= 20 ){
            println("Zu Erledigen: " + msg)
            stations[index].backgroundColor = UIColor.redColor()
            activity.text = msg
        }
        
    }
    
    func prepareLocations(){
        stationLocations.append(52.506493 , 13.332582, "Zeitung kaufen", "Kiosk")
        stationLocations.append(52.505546 , 13.332595, "Beten gehen", "Kirche")
        stationLocations.append(52.503706 , 13.346214, "Emma grüßen", "Emmas Haus")
        stationLocations.append(52.517792 , 13.372954, "Cool sein", "Half Pipe")
        stationLocations.append(52.518118 , 13.380085, "Hund streicheln", "Tierheim")
        stationLocations.append(52.516682 , 13.387436, "Blumen holen", "Blumenladen")
        stationLocations.append(52.519574 , 13.403986, "Eis essen", "Eisdiele")
        stationLocations.append(52.520458 , 13.405418, "Hundefutter kaufen", "Fressnapf")
        stationLocations.append(52.518000 , 13.374486, "Fahrrad checken lassen", "Fahrradwerkstatt")
        stationLocations.append(52.517344 , 13.366505, "Post abgeben", "Postamt")
        stationLocations.append(52.506560 , 13.351831, "Zigaretten kaufen", "Kiosk")
        stationLocations.append(52.504608 , 13.343148, "Nach Hause fahren", "Busstation")
        
        
        for element in stationLocations {
            var poi = Waypoint()
            var (lat, lon, msg, desc) = element
            poi.coordinate = CLLocationCoordinate2DMake(lat, lon)
            poi.title = desc
            poi.subtitle = msg
            mapView.addAnnotation(poi)
            
            
        }
    }
    
    /**
    Es gibt keine PDF von der aktuellen Übung... Da steht nur:
    Diese Aufgabe ist eine Erweiterung der Aufgabe "Kaisers Wegpunkte"
    Die Position des Benutzers soll auf der Karte angezeigt werden.
    Die 12 definierten Wegpunkte sollen als Pins auf der Karte vorhanden sein.
    Die Pins sollen beschriftet sein (Kurzname des Wegpunktes)
    Beim Erreichen des Wegpunktes soll entsprechende Meldung ausgegeben werden.
    Die Wegpunkte werden aus der Aufgabe "Kaisers Wegpunkte" übernommen.
    Viel Spaß!
    DM
    **/
    
}

