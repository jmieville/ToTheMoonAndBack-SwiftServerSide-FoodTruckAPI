//
//  ReviewsVC.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

class ReviewsVC: UIViewController {

    var selectedFoodTruck: FoodTruck?
    var dataService = DataService.instance
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        dataService.delegate = self
        
        if let truck = selectedFoodTruck {
            nameLabel.text = truck.name
            dataService.getAllReviews(truck, completion: { (Success) in
            })
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension ReviewsVC: DataServiceDelegate {
    func trucksLoaded() {
        // do not nothing
    }
    func reviewsLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func avgRatingUpdated() {
        // do nothing
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.reviews.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell {
            cell.configureCell(review: dataService.reviews[indexPath.row])
            return cell
        } else {
            return UITableViewCell()

        }
    }
}
