//
//  FriedrichsWegpunkt.swift
//  FriedrichKrauseMap
//
//  Created by Master-Student on 25/11/14.
//  Copyright (c) 2014 pennyland. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Station: MKPointAnnotation {
    let name: String = "Station"
    var radius: Double = 10
    
    init(title: String, coordinate: CLLocationCoordinate2D, radius: Double, subtitle: String) {
        super.init()
        super.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.radius = radius
    }
}
