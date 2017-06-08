//
//  AirbnbPlacesTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 07/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class AirbnbPlacesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
