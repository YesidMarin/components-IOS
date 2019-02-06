//
//  PlacesViewController.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: PlacesViewModel = {
        return PlacesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadTableViewModel = { () in
            self.tableView.reloadData()
        }
        
        viewModel.initFetch()
    }
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCellIdentifier", for: indexPath) as? PlaceListTableViewCell else { fatalError("Cell not exists")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.placeListCellViewModel = cellVM
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
