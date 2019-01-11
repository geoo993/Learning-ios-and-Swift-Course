//
//  BBCiPlayerStretchyChannelsCollectionViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 02/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerStretchyChannelsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelImage: UIImageView!
    
    /// same with UITableViewCell's selected backgroundColor
    private let highlightedColor = UIColor.bbciplayerPink 
    
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
    
    /// change it as you wish when or after initializing
    var shouldTintBackgroundWhenSelected = true
    
    /// you can give a special view when selected
    var specialHighlightedArea: UIView? 
    
    // make lightgray background display immediately
    override var isHighlighted: Bool { 
        willSet {
            onSelected(newValue)
        }
    }
    
    // keep lightGray background until unselected
    override var isSelected: Bool { 
        willSet {
            onSelected(newValue)
        }
    }
    
    func onSelected(_ newValue: Bool) {
        guard selectedBackgroundView == nil else { return }
        if shouldTintBackgroundWhenSelected {
            contentView.backgroundColor = newValue ? highlightedColor : UIColor.clear
        }
        if let area = specialHighlightedArea {
            area.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : UIColor.clear
        }
    }
}
