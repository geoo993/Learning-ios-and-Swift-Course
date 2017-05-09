//
//  Slide.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class Slide : UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        backgroundColor = UIColor.clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib()->UIView{
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String.init(describing: type(of:self)), bundle: bundle)
        let viewNib = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return viewNib
    }
    
}
