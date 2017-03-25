//
//  MainVC.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        
    }
    func reviewsLoaded() {
        // do nothing
    }
    func avgRatingUpdated() {
        // do nothing
    }
}
