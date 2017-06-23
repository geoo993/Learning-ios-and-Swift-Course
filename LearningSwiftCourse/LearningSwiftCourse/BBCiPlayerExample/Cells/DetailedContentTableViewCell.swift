//
//  DetailedContentTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 23/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class DetailedContentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView : UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    deinit {
        contentImageView = nil
        contentTitleLabel = nil
        contentDescriptionLabel = nil
    }
    
}
