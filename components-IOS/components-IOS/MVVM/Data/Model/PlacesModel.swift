//
//  PlacesModel.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation

struct InfoPlaces: Decodable {
    let response: Response
}

struct Response: Decodable {
    let venues: [NearPlaces]
}

struct NearPlaces: Decodable {
    let id: String
    let name:String
    let location: Location
    let categories: [Categories]
}

struct Location: Decodable {
    let address: String?
    let country: String
    let city: String?
    let state: String?
    let distance: Int
    let postalCode: String?
}

struct Categories: Decodable {
    let name: String
}
struct cityArray: Decodable {
    let city: [City]
    
}
struct City:Decodable {
    let cityID: Int
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityName = "cityName"
    }
}
