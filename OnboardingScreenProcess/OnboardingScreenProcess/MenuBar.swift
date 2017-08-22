//
//  MenuBar.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 14/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    let reuseIdentifier = "menuBarCell"
    
    var myReadingController : MyReadingViewController?
    
    let imageNames = ["To Read", "Reading", "Read"]
    let colors : [UIColor] = [.orange, .yellow, .cyan]
    
    
    @IBOutlet weak var collectionView : UICollectionView!
       
    @IBOutlet weak var horizontalbarView : UIView!
    @IBOutlet weak var horizontalbarLeftAnchorConstraint: NSLayoutConstraint!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    func setupView(){
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        setupHorizontalBar()
    }
    
    func setupHorizontalBar(){
        
        horizontalbarView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalbarView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func selectItem(with index: Int){
        // Select
        let selectedIndexPath = IndexPath(item: index, section: 0)
        collectionView?.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
    }
    
    func deselectItem(with index: Int){
        // Deselect
        let deselectedIndexPath = IndexPath(item: index, section: 0)
        collectionView?.deselectItem(at: deselectedIndexPath, animated: true)
    }
    
    func animateToIndex(with index: Int){
        let x = CGFloat(index) * (frame.width / CGFloat(imageNames.count) )
        horizontalbarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

}

// MARK: UICollectionViewDataSource
extension MenuBar : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuBarCell
        
        let menu = imageNames[indexPath.item] 
        cell.setLabel(with: menu)
        
        return cell
    }

}

// MARK: UICollectionViewDelegate
extension MenuBar : UICollectionViewDelegate {
    
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
     }
     
     // Uncomment this method to specify if the specified item should be selected
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //animateToIndex(with: indexPath.item)
        myReadingController?.scrollToMenuIndex(with: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MenuBar : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth : CGFloat = frame.width / CGFloat(imageNames.count)
        let itemHeight : CGFloat = layout?.itemSize.height ?? 60
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

