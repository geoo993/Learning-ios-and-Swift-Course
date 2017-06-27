//
//  IntroScreenTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 05/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class SummaryViewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder) 
//    }
    
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.layer.cornerRadius = 10
        //self.clipsToBounds = true
    }
    

}
