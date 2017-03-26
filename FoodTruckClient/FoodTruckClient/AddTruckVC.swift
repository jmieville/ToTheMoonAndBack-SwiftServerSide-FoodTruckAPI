//
//  AddTruckVC.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

class AddTruckVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var foodTypeField: UITextField!
    @IBOutlet weak var avgCostField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var spinner: UIActivity!
    
    var dataService = DataService.instance

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        guard let name = nameField.text, nameField.text != "" else {
            showAlert(with: "Error", message: "Please enter a name")
            return
        }
        guard let foodType = foodTypeField.text, foodTypeField.text != "" else {
            showAlert(with: "Error", message: "Please enter a food type")
            return
        }
        guard let avgCost = Double(avgCostField.text!), avgCostField.text != "" else {
            showAlert(with: "Error", message: "Please enter an average cost")
            return
        }
        guard let latitude = Double(latField.text!), latField.text != "" else {
            showAlert(with: "Error", message: "Please enter a latitude")
            return
        }
        guard let longitude = Double(longitudeField.text!), longitudeField.text != "" else {
            showAlert(with: "Error", message: "Please enter a longitude")
            return
        }
        
        dataService.addNedFoodTruck(name, foodType: foodType, avgCost: avgCost, latitude: latitude, longitude: longitude) { Success in
            if Success {
                print("\(name) was added successfully")
                self.dataService.getAllFoodTrucks(completion: { (Success) in
                    if Success {
                        self.dismissViewController()
                    } else {
                        print("An Error occurred")
                        self.showAlert(with: "Error", message: "An error occurred saving the new food truck, please try again.")
                    }
                })
            } else {
                self.showAlert(with: "Error", message: "An error occurred saving the new food truck, please try again.")
                print("We didn't save successfully")
            }
        }
        
    }
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    
    func dismissViewController() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(with title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
