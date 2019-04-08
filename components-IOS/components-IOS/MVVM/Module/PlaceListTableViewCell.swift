//
//  PlaceListTableViewCell.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit

class PlaceListTableViewCell: UITableViewCell {

    @IBOutlet weak var namePlace: UILabel!
    @IBOutlet weak var nameCategorie: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var address: UILabel!
    
    // get value of view model in cell properties
    var placeListCellViewModel: PlaceListCellViewModel?{
        didSet {
            let namePlaceViewModel = placeListCellViewModel?.namePlace ?? ""
            let nameCategorieViewModel = placeListCellViewModel?.nameCategorie ?? ""
            let postalCodeViewModel = placeListCellViewModel?.postalCode ?? ""
            let countryViewModel = placeListCellViewModel?.country ?? ""
            namePlace.text = namePlaceViewModel
            nameCategorie.text =  "Categorie: \(nameCategorieViewModel)"
            address.text = "Address: \(postalCodeViewModel)"
            country.text = countryViewModel
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
