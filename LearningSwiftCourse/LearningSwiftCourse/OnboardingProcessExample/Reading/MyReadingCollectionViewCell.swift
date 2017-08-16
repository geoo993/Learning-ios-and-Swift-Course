//
//  MyReadingCollectionViewCell.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

@IBDesignable
class MyReadingCollectionViewCell: BaseCell {
    
    //top
    @IBOutlet weak var bookTitleLabel : UILabel!
    @IBOutlet weak var bookImageView : LayoutableImageView!
    @IBOutlet weak var ratingsView : RatingsView!
    @IBOutlet weak var continueReadingButton : LayoutableButton!
    @IBAction func continueReadingButtonAction (_ sender : LayoutableButton){
        myReading?.didCompleteBookSelection.onNext(currentBook)
    }
    
    @IBOutlet weak var playgameButton : LayoutableButton!
    @IBAction func playgameButtonAction (_ sender : LayoutableButton){
        print("play game")
    }
    
    //bottom
    @IBOutlet weak var trickyWordsTitleLabel : UILabel!
    
    fileprivate var currentBook = ""
    
    var myReading : MyReadingViewController?
    
    override func setupViews(){
        super.setupViews()
    }
    
    func setBook (with bookName : String){
        currentBook = bookName
        bookTitleLabel?.text = currentBook
    }
    
    func setReadingButton (with name : String){
        continueReadingButton?.setTitle(name, for: .normal)
    }
    
    
}
