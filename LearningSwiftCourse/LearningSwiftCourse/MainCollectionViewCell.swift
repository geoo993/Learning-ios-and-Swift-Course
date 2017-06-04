//
//  MainCollectionViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import IBAnimatable

@IBDesignable
class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImageView: AnimatableImageView!
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) 
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
