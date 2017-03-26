//
//  AddReviewVC.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController {

    var selectedFoodTruck: FoodTruck?
    var dataService = DataService.instance
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var reviewTitleTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var starRatingStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()

        if let truck = selectedFoodTruck {
            headerLabel.text = truck.name
        } else {
            headerLabel.text = "Error"
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        guard let truck = selectedFoodTruck else {
            showAlert(with: "Error", message: "Could not get selected truck")
            return
        }
        guard let title = reviewTitleTextField.text, reviewTitleTextField.text != "" else {
            showAlert(with: "Error", message: "Please enter a title for your review")
            return
        }
        guard let text = reviewTextField.text, reviewTextField.text != "" else {
            showAlert(with: "Error", message: "Please enter a text for your review")
            return
        }
        
        let rating = Int(starRatingStepper.value)
        dataService.addNewReview(truck.docId, title: title, text: text, rating: rating) { (Success) in
            if Success {
                print("Review successfully added")
                self.dataService.getAverageStarRatingForTruck(truck, completion: { (Success) in
                    if Success {
                        self.dismissViewController()
                    } else {
                        self.showAlert(with: "Error", message: "An unknown error has occurred")
                    }
                })
            } else {
                self.showAlert(with: "Error", message: "An error occurred saving the new review")
            }
        }
    }
    @IBAction func stepperValueDidChange(sender: UIStepper) {
        let newValue = Int(sender.value)
        starRatingLabel.text = "\(newValue)"
    }
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    func dismissViewController() {
        DispatchQueue.main.async {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(with title: String?, message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        spinner.stopAnimating()
    }
}
