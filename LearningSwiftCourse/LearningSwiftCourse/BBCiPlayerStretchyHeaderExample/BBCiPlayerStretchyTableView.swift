//
//  BBCiPlayerStretchyTableView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 27/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerStretchyTableView: UITableView {

    @IBOutlet weak var navBar : UINavigationBar!
    
    /*
     override init(frame: CGRect) {
     super.init(frame: frame)
     
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     }
     
     public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
     }

     
     public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateNavBarVisibility()
        
     }
     
    func updateNavBarVisibility (){
        
        let yPosition = self.frame.origin.y
        let difference = yPosition.percentageWithF(maxValue: -275, minValue: -284) / 100
        navBar.alpha = 1 - abs(difference)
        navBar.isHidden = (navBar.alpha < 0.05)
    }
    
    
}
