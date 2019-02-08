//
//  ViewController.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vcPlaces: PlacesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vcPlaces = storyboard?.instantiateViewController(withIdentifier: "PlaceList") as? PlacesViewController
        navigationController?.pushViewController(vcPlaces!, animated: true)
    }

    @IBAction func showListPlacesNearby (_ sender: UIButton) {
       
        self.present(vcPlaces!, animated: true, completion: nil)
    }

}


