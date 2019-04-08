//
//  LocationManager.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/8/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var coordinates = Coordinates() {
        didSet {
            self.initFetch()
        }
    }
    
    var initFetch: (() -> ()) = {}
    
}

extension LocationManager : CLLocationManagerDelegate {
    
    func initLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { fatalError("Not Location")}
        let locValue: CLLocationCoordinate2D = location.coordinate
        coordinates.latitude = Float(locValue.latitude)
        coordinates.longitude = Float(locValue.longitude)
        print("location \(location),latitude \(locValue.latitude), longitude \(locValue.longitude)")
    }
    
}
