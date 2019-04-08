//
//  APIService.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getNearPlace(latitude: Float, longitude: Float, complete: @escaping ( _ success: Bool, _ place: InfoPlaces)->())
    //func getCity(complete: @escaping (_ success: Bool) ->())
}

class APIService: APIServiceProtocol {
    
    /*func getCity(complete: @escaping (Bool) -> ()) {
        let urlString = "http://192.168.10.116:8030/api/city"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data,_,error in
            DispatchQueue.main.sync {
                if let error = error {
                    print("Faild", error)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    typealias sad = [City]
                    let places = try decoder.decode(sad.self, from: data)
                    print(places)
                    complete(true)
                } catch let jsonError {
                    print(jsonError)
                    return
                }

            }
        }.resume()
    }
    */
    
    func getNearPlace(latitude: Float, longitude: Float, complete: @escaping (Bool, InfoPlaces) -> ()) {
        let urlString = "https://api.foursquare.com/v2/venues/search?ll=\(latitude),%20\(longitude)&client_id=IJEWNYNTYDJ4SUU00FO0CTSW50IDXWPG2MIZLBPG5WEL4TXQ&client_secret=SX0RDDTIAF1RZXBFVITY0SK2M0XZUMKDNYR5MDDPILT5BGGN&v=20190201&limit=20"
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
