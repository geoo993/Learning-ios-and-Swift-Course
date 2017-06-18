//
//  StretchyHeaderTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class StretchyHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContinentLabel: UILabel!
    @IBOutlet weak var cellCountryLabel: UILabel!
    @IBOutlet weak var cellSummaryLabel: UILabel!
    
    var newsItem: NewStretchyHeaderItem? {  
        didSet {
            if let item = newsItem {
                cellContinentLabel.text = item.continent.toString()
                cellContinentLabel.textColor = item.continent.toColor()
                cellCountryLabel.text = item.country
                cellSummaryLabel.text = item.summary
            }
            else {
                cellContinentLabel.text = nil
                cellCountryLabel.text = nil
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
