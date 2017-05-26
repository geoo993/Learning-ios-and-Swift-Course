//
//  InspirationalFilmsCollectionViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class InspirationalFilmsCollectionViewCell: UICollectionViewCell {
    
    var inspirationalFilm : InspirationalFilms! {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var inspirationalFilmsCoverImageButton: UIButton!
    @IBAction func inspirationalFilmsCoverImageButtonAction(_ sender: UIButton) {
       
        InspirationalFilmsViewController.updateInspirationalFilm.onNext(inspirationalFilm.title)
    }
    
    
    public func updateUI(){
        inspirationalFilmsCoverImageButton.setImage(inspirationalFilm.coverImage, for: .normal)
    }
    
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
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
