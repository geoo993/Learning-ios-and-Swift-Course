//
//  BBCiPlayerContentTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerContentTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHeadingView : UIImageView!
    @IBOutlet weak var imageHeadingLabel : UILabel!
    @IBOutlet weak var channelLabel : UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectedBackgroundView = UIView()
        channelLabel.textColor = UIColor.bbciplayerPink()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectedBackgroundView!.backgroundColor = selected ? .red : nil
        // Configure the view for the selected state
    }
    
    
    deinit {
        imageHeadingView = nil
        imageHeadingLabel = nil
        channelLabel = nil
        titleLabel = nil
        descriptionLabel = nil
    }
}
