//
//  MyReadingSectionsCollectionViewCell.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 16/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

@IBDesignable
class MyReadingSectionsCollectionViewCell: BaseCell {
    
    let identifier = "myReadingCell"
    @IBOutlet weak var booksCollectionView : UICollectionView!
    @IBOutlet weak var leftAnchorConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightAnchorConstraint: NSLayoutConstraint!
    
    
    var selectedBooks = [String]()
    var readingTitle = ""
    var myReadingController : MyReadingViewController?
    
    func setupCollectionView() {
        booksCollectionView?.backgroundColor = UIColor.white
    }
    
    override func setupViews(){
        super.setupViews()
        
        setupCollectionView()
    }
    
}

// MARK: UICollectionViewDataSource
extension MyReadingSectionsCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return selectedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) 
            as! MyReadingCollectionViewCell
        
        let text = selectedBooks[indexPath.item]
        cell.myReading = myReadingController
        cell.setBook(with: text)
        cell.setReadingButton(with: readingTitle)
        
        return cell
    }
    
}


// MARK: UICollectionViewDelegate
extension MyReadingSectionsCollectionViewCell : UICollectionViewDelegate {
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyReadingSectionsCollectionViewCell : UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
     
        //let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth : CGFloat = frame.width - leftAnchorConstraint.constant - rightAnchorConstraint.constant
        let itemHeight : CGFloat = frame.height
        return CGSize(width: itemWidth , height: itemHeight) 
     }

}
