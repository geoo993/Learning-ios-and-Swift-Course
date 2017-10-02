//
//  DogsResultsTableViewCell.swift
//  DogSearch
//
//  Created by GEORGE QUENTIN on 02/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class DogsResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel : UILabel!
    @IBOutlet weak var cellImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
