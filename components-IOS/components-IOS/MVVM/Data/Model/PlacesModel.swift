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
}
