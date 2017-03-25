//
//  DetailsVC.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit
import MapKit


class DetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var dataService = DataService.instance
    var selectedFoodTruck: FoodTruck?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataService.delegate = self
        
        guard let truck = selectedFoodTruck else {
            _ = navigationController?.popViewController(animated: true)
            return
        }
        
        dataService.getAverageStarRatingForTruck(truck)
        
        nameLabel.text = truck.name
        foodTypeLabel.text = truck.foodType
        avgRatingLabel.text = "\(dataService.avgRating)"
        avgCostLabel.text = "$\(truck.avgCost)"
        
        mapView.addAnnotation(truck)
        centerMapOnLocation(CLLocation(latitude: truck.latitude, longitude: truck.longitude))
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(selectedFoodTruck!.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reviewsButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func addReviewButtonTapped(sender: UIButton) {
        
    }

}

extension DetailsVC: DataServiceDelegate {
    
    func trucksLoaded() {
        // do nothing
    }
    func reviewsLoaded() {
        // do nothin
    }
    func avgRatingUpdated() {
        OperationQueue.main.addOperation {
            let rating = self.dataService.avgRating
            self.avgRatingLabel.text = "\(rating)"
        }
    }
}
