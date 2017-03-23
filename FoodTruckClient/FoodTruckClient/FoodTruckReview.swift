//
//  FoodTruckReview.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/22/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

struct FoodTruckReview {
    var docId: String = ""
    var truckId: String = ""
    var reviewTitle: String = ""
    var reviewText: String = ""
    var starRating: Int = 0
    
    static func parseReviewJSONData(data: Data) -> [FoodTruckReview] {
        var foodTruckReviews = [FoodTruckReview]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            // Parse JSON data
            if let reviews = jsonResult as? [Dictionary<String,AnyObject>] {
                for review in reviews {
                    var newReview = FoodTruckReview()
                    newReview.docId = review["id"] as! String
                    newReview.truckId = review["truckid"] as! String
                    newReview.reviewTitle = review["reviewtitle"] as! String
                    newReview.reviewText = review["reviewtext"] as! String
                    newReview.starRating = review["starrating"] as! Int
                    
                    foodTruckReviews.append(newReview)
                }
            }
            
        } catch let err{
            print(err)
        }
        return foodTruckReviews
    }
}
