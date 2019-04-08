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
    
    
    private var cellViewModels: [PlaceListCellViewModel] = [PlaceListCellViewModel]() {
        didSet {
            self.reloadTableViewModel()
            self.getCityLocationCurrency()
        }
    }
    
    var cityLocation = "" {
        didSet {
            self.changeNameCity()
        }
    }
    
    private var places: [NearPlaces] = [NearPlaces]()
    var reloadTableViewModel: (()->()) = {}
    var changeNameCity: (() -> ()) = {}
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
        self.apiService.getNearPlace(latitude: locationManasger.coordinates.latitude , longitude: locationManasger.coordinates.longitude) { (success, places) in
            self.PlacesNearby = places
            self.prepareNewNearPlace(places: places.response.venues)
        }
        /*apiService.getCity { (success) in
            print("Yeah call from .NET and MySQL")
        }*/
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
        let postalCode = places.location.address ?? ""
        let country = places.location.country
        return PlaceListCellViewModel( namePlace: places.name, nameCategorie: nameCategorie, postalCode: postalCode, country: country)
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PlaceListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func getCityLocationCurrency(){
        guard let cities = PlacesNearby?.response.venues else { return }
        for city in cities {
            if let city = city.location.city {
                cityLocation = city
                break
            }
        }
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
        
        locationManasger.initLocation()
        
        locationManasger.initFetch = { () in
            self.initFetch()
        }
    }
}

