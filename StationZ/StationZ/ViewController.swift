//
//  ViewController.swift
//  StationZ
//
//  Created by Master-Student on 04/01/15.
//  Copyright (c) 2015 pennyland. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    
    var pois: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        map.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var url: NSURL = NSURL(string: "http://www.berlin.de/special/gesundheit-und-beauty/adressen/apotheke/")!
        var err:NSError?
        
        var htmlDoc = HTMLDocument(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &err)
        
        var pager = htmlDoc?.body?.nodeWithClass("bde-pager")
        var pagerItems = pager?.childrenOfTag("a")
        var index = pagerItems?.endIndex
        var numberOfPagesString = pagerItems?[index!-2].rawTextContent
        var numberOfPages = numberOfPagesString!.toInt()
        
        var count: Int = 0;
        
        for (var i = 1; i <= numberOfPages; i++) {
            var nextUrlString = url.absoluteString! + "?trpg=" + String(i)
            var nextUrl: NSURL = NSURL(string: nextUrlString)!
            
            htmlDoc = HTMLDocument(contentsOfURL: nextUrl, encoding: NSUTF8StringEncoding, error: &err)
            
            var teasers = htmlDoc?.body?.nodesWithClass("teaser shofi ")
            
            println("Seite: " + String(i))
            for (var j = 0; j < teasers?.count; j++) {
                var header = teasers?[j].descendantOfTag("h3")
                header = header?.childOfTag("a")?
                var string = header?.rawTextContent
                count++;
                println(String(count) + " " + string!)
            }
            
        }
        generateStations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let currentLocation = userLocation.location.coordinate
        self.map.region = MKCoordinateRegionMakeWithDistance(currentLocation, 1500, 1500)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (!(annotation is Station) || ((annotation as Station).name != "Station")) {
            return nil
        }
        let reuseId = "Station"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView.canShowCallout = true
        } else {
            annotationView.annotation = annotation
        }
        
        return annotationView
    }
    
    func locationManager(manager:CLLocationManager,
        didUpdateLocations locations:[AnyObject])
    {
        var loc = locations.last as CLLocation
        
        for (var i = 0; i < pois.endIndex; i++) {
            var poi = pois[i]
            var sLocation = CLLocation(latitude: poi.coordinate.latitude, longitude: poi.coordinate.longitude)
            if(sLocation.distanceFromLocation(loc) < poi.radius) {
                reachStation(i)
                return
            }
            self.map.deselectAnnotation(pois[i], animated: true)
        }
    }
    
    func reachStation(stationNummber: Int) {
        if(stationNummber < 0 || stationNummber >= 12) {
            return
        }
        self.map.selectAnnotation(pois[stationNummber], animated: true)
    }
    
    
    func generateStations() {
        pois.append(Station(title: "Zeitungsstand", coordinate: CLLocationCoordinate2DMake(52.506259, 13.332291), radius: 50, subtitle: "Tageszeitung kaufen"))
        pois.append(Station(title: "Kiosk", coordinate: CLLocationCoordinate2DMake(52.505664, 13.332290), radius: 50, subtitle: "Nach Sudoku für Frauchen fragen"))
        pois.append(Station(title: "Supermarkt", coordinate: CLLocationCoordinate2DMake(52.505005, 13.335213), radius: 60, subtitle: "Katzenfutter kaufen"))
        pois.append(Station(title: "Gulli", coordinate: CLLocationCoordinate2DMake(52.505098, 13.339336), radius: 30, subtitle: "In den Gulli Spucken"))
        pois.append(Station(title: "Ampel", coordinate: CLLocationCoordinate2DMake(52.504733, 13.341834), radius: 30, subtitle: "Bei rot stehen bleiben, bei grün gehen"))
        pois.append(Station(title: "Dönerladen", coordinate: CLLocationCoordinate2DMake(52.504230, 13.343838), radius: 50, subtitle: "Gemüsedöner kaufen"))
        pois.append(Station(title: "Späti", coordinate: CLLocationCoordinate2DMake(52.503776, 13.345828), radius: 50, subtitle: "Drei Hubertustropfen kaufen"))
        pois.append(Station(title: "Parkbank", coordinate: CLLocationCoordinate2DMake(52.503411, 13.347358), radius: 30, subtitle: "Döner essen, Hubertustropfen trinken"))
        pois.append(Station(title: "Mülleimer", coordinate: CLLocationCoordinate2DMake(52.502944, 13.349753), radius: 30, subtitle: "Dönerpapier entsorgen"))
        pois.append(Station(title: "Blumenladen", coordinate: CLLocationCoordinate2DMake(52.503459, 13.350481), radius: 50, subtitle: "Einzelne Blume kaufen"))
        pois.append(Station(title: "Friedhof", coordinate: CLLocationCoordinate2DMake(52.504282, 13.351221), radius: 80, subtitle: "Blume aufs Grab der Mutter legen"))
        pois.append(Station(title: "Zeitmaschine", coordinate: CLLocationCoordinate2DMake(52.505434, 13.352186), radius: 50, subtitle: "Tag von vorne beginnen"))
        for poi in pois {
            map.addAnnotation(poi)
        }
    }



}

