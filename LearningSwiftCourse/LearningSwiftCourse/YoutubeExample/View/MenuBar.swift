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
    
    var homeController : YoutubeHomeCollectionViewController?
    
    var imageNames : [String]? 
    
    var horizontalbarLeftAnchorConstraint: NSLayoutConstraint?
    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:50,height: 50)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout )
        cv.backgroundColor = UIColor.topMenuRedColor()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self 
        cv.dataSource = self 
        return cv
    }()
    
    func setupView(){
        
        // Register cell classes
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: reuseIdentifier)
   
        addSubview(collectionView)
        addConstraints(with: "H:|[v0]|", views: collectionView)
        addConstraints(with: "V:|[v0]|", views: collectionView)
        
        setupHorizontalBar()
        selectItem(with: 0)
    }
    
    func setupHorizontalBar(){
        //let itemWidth = frame.width
        let itemWidthRatio : CGFloat = 1 / 4 //layout?.itemSize.width ?? 300
        let horizontalbarView = UIView()
        horizontalbarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalbarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalbarView)
        
        //old school frame way of doing thing
        //horizontalbarView.frame = CGRect(x: 0, y: 0, width: itemWidth, height: 10)
        
        //new school frame way of layout our views
        //need x, y, width, height constraint
        horizontalbarLeftAnchorConstraint = horizontalbarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalbarLeftAnchorConstraint?.isActive = true
        horizontalbarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalbarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: itemWidthRatio).isActive = true
        horizontalbarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
    }
    
    func selectItem(with index: Int){
        // Select
        let selectedIndexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition:UICollectionViewScrollPosition.centeredVertically)
        //collectionView(collectionView, didSelectItemAt: selectedIndexPath) 
    }
    
    func deselectItem(with index: Int){
        // Deselect
        let deselectedIndexPath = IndexPath(item: index, section: 0)
        collectionView.deselectItem(at: deselectedIndexPath, animated: true)
        //collectionView(collectionView, didDeselectItemAt: deselectedIndexPath)
    }
    
    func animateToIndex(with index: Int){
        let x = CGFloat(index) * (frame.width / 4)
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuBarCell
        
        if let menu = imageNames?[indexPath.item] {
            cell.setImage(with: menu.lowercased() )
        }
        
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
        homeController?.scrollToMenuIndex(with: indexPath.item)
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
        
        //let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = frame.width / 4 //layout?.itemSize.width ?? 300
        let itemHeight = frame.height //layout?.itemSize.height ?? 40 
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

