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
    
    // get value of view model in cell properties
    var placeListCellViewModel: PlaceListCellViewModel?{
        didSet {
            namePlace.text = placeListCellViewModel?.titleText
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
