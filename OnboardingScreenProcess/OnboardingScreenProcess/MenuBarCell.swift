//
//  MenuBarCell.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 14/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

@IBDesignable
class MenuBarCell: BaseCell {

    @IBOutlet weak var titleLabel : UILabel!
    
    override var isHighlighted : Bool {
        didSet {
            titleLabel?.textColor = isHighlighted ? UIColor.black : UIColor.gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel?.textColor = isSelected ? UIColor.black : UIColor.gray
        }
    }
    
    override func setupViews(){
       super.setupViews()
    }
   
    func setLabel(with name : String){
        titleLabel?.text = name
        titleLabel?.textColor = UIColor.gray
    }
    
}
