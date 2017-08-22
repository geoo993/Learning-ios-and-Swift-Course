//
//  BaseCell.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 14/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  
    func setupViews(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
}
