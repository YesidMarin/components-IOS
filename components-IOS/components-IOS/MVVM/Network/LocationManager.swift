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


     var reloasdTableViewModel: (()->()) = {}
    
    private let locationManager = CLLocationManager()
    
    private var coordinates = Coordinates() {
        didSet {
            print(coordinates.latitude)
            print(coordinates.longitude)
            self.reloasdTableViewModel()
        }
    }
}

extension LocationManager : CLLocationManagerDelegate {
    
    func initLocation () {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinatesAccuracy: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        coordinates.longitude = Float(coordinatesAccuracy.longitude)
        coordinates.latitude = Float(coordinatesAccuracy.latitude)
    }
}
