//
//  PlacesViewModel.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation

class PlacesViewModel {
    
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
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        apiService.getNearPlace { (success, places) in
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
        return PlaceListCellViewModel( titleText: places.name )
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PlaceListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
}

struct PlaceListCellViewModel {
    let titleText: String
}
