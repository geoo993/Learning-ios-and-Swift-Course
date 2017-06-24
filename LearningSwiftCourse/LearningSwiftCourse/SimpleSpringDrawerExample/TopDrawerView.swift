//
//  TopDrawerView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class TopDrawerView: UIView {

    var parentView = UIView()
    
    init(frame: CGRect, parent : UIView){
        super.init(frame: frame)
        self.parentView = parent
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if self.superview != nil {
            self.parentView = self.superview!
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    

}
