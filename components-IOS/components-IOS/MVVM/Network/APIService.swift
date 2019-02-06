//
//  APIService.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getNearPlace(complete: @escaping ( _ success: Bool, _ place: InfoPlaces)->())
}

class APIService: APIServiceProtocol {
    func getNearPlace(complete: @escaping (Bool, InfoPlaces) -> ()) {
        let urlString = "https://api.foursquare.com/v2/venues/search?ll=4.618395,%20-74.070536&client_id=IJEWNYNTYDJ4SUU00FO0CTSW50IDXWPG2MIZLBPG5WEL4TXQ&client_secret=SX0RDDTIAF1RZXBFVITY0SK2M0XZUMKDNYR5MDDPILT5BGGN&v=20190201&limit=20"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data,_,error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Faild", error)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let places = try decoder.decode(InfoPlaces.self, from: data)
                    complete(true, places)
                } catch let jsonError {
                    print(jsonError)
                    return
                }
            }
            }.resume()
    }
}
