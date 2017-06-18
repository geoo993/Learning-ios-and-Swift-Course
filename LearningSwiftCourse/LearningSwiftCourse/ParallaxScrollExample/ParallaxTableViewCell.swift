//
//  ParallaxTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class ParallaxTableViewCell: UITableViewCell {

    @IBOutlet weak var parallaxImageView: UIImageView!
    @IBOutlet weak var parallaxImageLabel: UILabel!
    
    // MARK: ParallaxCell
    
    @IBOutlet weak var parallaxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
        parallaxImageView.contentMode = .scaleAspectFill
        parallaxImageView.clipsToBounds = false
        self.backgroundColor = UIColor.randomColor()
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
   
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.backgroundColor = UIColor.randomColor()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}
