//
//  PlacesViewModel.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation
import CoreLocation

class PlacesViewModel: NSObject  {
    
    lazy var locationManasger: LocationManager = {
        return LocationManager()
    }()
    
    let locationManager = CLLocationManager()
    
    private var cellViewModels: [PlaceListCellViewModel] = [PlaceListCellViewModel]() {
        didSet {
            self.reloadTableViewModel()
        }
    }
    private var places: [NearPlaces] = [NearPlaces]()
    var reloadTableViewModel: (()->()) = {}
    var numberOfCells: Int {
        return cellViewModels.count
    }
    let apiService: APIServiceProtocol

    private var coordinates = Coordinates.init()
    
    private var PlacesNearby: InfoPlaces?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        apiService.getNearPlace(latitude: coordinates.latitude , longitude: coordinates.longitude) { (success, places) in
            self.PlacesNearby = places
            self.prepareNewNearPlace(places: places.response.venues)
        }
    }
    
    func prepareNewNearPlace(places: [NearPlaces]){
        self.places = places
        var nearPlaceCell = [PlaceListCellViewModel]()
        for place in places {
            nearPlaceCell.append(createCellViewModel(places: place))
        }
        self.cellViewModels = nearPlaceCell
        print(places)
    }
    
    func createCellViewModel( places: NearPlaces ) -> PlaceListCellViewModel {
        let nameCategorie = places.categories.first?.name ?? ""
        let postalCode = places.location.postalCode ?? ""
        let country = places.location.country
        return PlaceListCellViewModel( namePlace: places.name, nameCategorie: nameCategorie, postalCode: postalCode, country: country)
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PlaceListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func getCityLocationCurrency() -> String {
        guard let cities = PlacesNearby?.response.venues else { return ""}
        var cityCurrency = ""
        for city in cities {
            if let city = city.location.city {
                cityCurrency = city
                break
            }
        }
        return cityCurrency
    }
    
}

struct PlaceListCellViewModel {
    let namePlace: String
    let nameCategorie: String
    let postalCode: String
    let country: String
}

extension PlacesViewModel: CLLocationManagerDelegate {
    
    func initLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { fatalError("Not Location")}
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        coordinates.latitude = Float(locValue.latitude)
        coordinates.longitude = Float(locValue.longitude)
        print("location \(location),latitude \(locValue.latitude), longitude \(locValue.longitude)")
        initFetch()
    }
}

