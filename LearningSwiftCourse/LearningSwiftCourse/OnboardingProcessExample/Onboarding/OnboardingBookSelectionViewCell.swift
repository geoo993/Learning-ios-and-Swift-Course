//
//  OnboardingBookSelectionViewCell.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

@IBDesignable
class OnboardingBookSelectionViewCell: BaseCell {
    
    @IBOutlet weak var favouriteBookImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    var isItemSelected: Bool = false {
        didSet {
            backgroundColor = isItemSelected ? UIColor.green : UIColor.white
            setImage(with: isItemSelected)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
    }
    
    func setImage(with selected : Bool){
        let imageName = selected ? "heart" : "heart_transparent"
        favouriteBookImageView.image = UIImage(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        favouriteBookImageView.tintColor = selected ? UIColor.white : UIColor.gray
    }
    
}
