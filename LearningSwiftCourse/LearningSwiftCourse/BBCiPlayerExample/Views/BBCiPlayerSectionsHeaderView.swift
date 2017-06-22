//
//  BBCiPlayerSectionsHeaderView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerSectionsHeaderView: UIView {
    
    @IBOutlet weak var sectionsHeaderImageView : UIImageView!
    @IBOutlet weak var labelsPanelView : UIView!
    @IBOutlet weak var channelLabel : UILabel!
    @IBOutlet weak var contentTitleLabel : UILabel!
    @IBOutlet weak var contentDescriptionLabel : UILabel!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


     override init(frame: CGRect) {
     super.init(frame: frame)
     
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     override func awakeFromNib() {
     super.awakeFromNib()
     // Initialization code
     }
     
     public override func willMove(toSuperview newSuperview: UIView?) {
     super.willMove(toSuperview: newSuperview)
     }
     
     public override func layoutSubviews() {
     super.layoutSubviews()
     
     }
     
     */
    
    deinit {
        
    }
}
