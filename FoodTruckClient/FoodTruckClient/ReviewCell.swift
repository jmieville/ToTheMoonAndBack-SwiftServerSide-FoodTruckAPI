//
//  ReviewCell.swift
//  FoodTruckClient
//
//  Created by Jean-Marc Kampol Mieville on 3/25/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(review: FoodTruckReview) {
        titleLabel.text = review.reviewTitle
        textLabel?.text = review.reviewText
    }

}
