//
//  YoutubeMenuBarCell.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 14/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class YoutubeMenuBarCell: BaseCell {

    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        iv.tintColor = UIColor.nonSelectedColor
        return iv
    }()
    
    override var isHighlighted : Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.nonSelectedColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.nonSelectedColor
        }
    }
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(imageView)
//        addConstraints(with: "H:|[v0(28)]", views: imageView)
//        addConstraints(with: "V:|[v0(28)]", views: imageView)
//        addCenterConstraints(with: imageView)
        
        let size : CGFloat = 28
        let xPos = (frame.width - size) / 2
        let yPos = (frame.height - size) / 2
        let imageFrame = CGRect(x: xPos, y: yPos, width: size, height: size)
        imageView.frame = imageFrame
        
        
        //self.layoutIfNeeded()
    }
   
    func setImage(with name : String){
        
        print(name)
        let img = UIImage(named: name)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.image = img
    }
    
}
