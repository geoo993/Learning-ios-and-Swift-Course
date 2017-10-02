//
//  DogsTableViewCell.swift
//  DogSearch
//
//  Created by GEORGE QUENTIN on 02/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

public class DogsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel : UILabel!
    @IBOutlet weak var cellImage : UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
