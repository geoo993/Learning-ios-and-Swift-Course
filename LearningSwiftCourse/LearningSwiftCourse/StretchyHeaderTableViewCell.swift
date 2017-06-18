//
//  StretchyHeaderTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class StretchyHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var cellHeadlineLabel: UILabel!
    @IBOutlet weak var cellSummaryLabel: UILabel!
    
    var newsItem: NewStretchyHeaderItem? {  
        didSet {
            if let item = newsItem {
                cellHeadlineLabel.text = item.continent.toString()
                cellHeadlineLabel.textColor = item.continent.toColor()
                cellSummaryLabel.text = item.summary
            }
            else {
                cellHeadlineLabel.text = nil
                cellSummaryLabel.text = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
