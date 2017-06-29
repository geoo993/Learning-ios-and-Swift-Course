//
//  MenuItemCell.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class AnimatableSideMenuItemCell: UITableViewCell {
  
  @IBOutlet weak var menuItemImageView: UIImageView!
  
    func configureForMenuItem(menuItem: NSDictionary) {
        menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
        backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
    }
  
}
