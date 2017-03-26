//
//  Constants.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/22/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

// Callbacks
// Typealias for callbacks used in data service
typealias callback = (_ success: Bool) -> ()

// Base URL
//let BASE_API_URL = "http://localhost:8080/api/v1"
 let BASE_API_URL = "https://marc-foodtruck-api.au-syd.mybluemix.net/api/v1"

// Get all food trucks
let GET_ALL_FT_URL = "\(BASE_API_URL)/trucks"

// GET all reviews for a specific truck
let GET_ALL_FT_REVIEWS = "\(BASE_API_URL)/trucks/reviews"

// GET star rating for a specific food truck
let GET_FT_STAR_RATING = "\(BASE_API_URL)/reviews/rating"

// POST add new Food truck
let POST_ADD_NEW_TRUCK = "\(BASE_API_URL)/trucks"

// ADD review for a specific truck
let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/reviews"
