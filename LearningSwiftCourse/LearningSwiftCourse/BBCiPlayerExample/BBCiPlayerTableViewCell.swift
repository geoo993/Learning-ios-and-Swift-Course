//
//  BBCiPlayerTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var collectionViewContentInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2) 
    var collectionData : [BBCiPlayerVideosItems] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BBCiPlayerTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iplayerTableViewCollectionViewCell", for: indexPath) as! BBCiPlayerTableviewCollectionViewCell
        cell.titleLabel.text = collectionData[indexPath.row].videoTitle 
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension BBCiPlayerTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionViewCell selected \(indexPath)")
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BBCiPlayerTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let screen = UIScreen.main.bounds
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = (screen.size.width - 16) / 2
        //let itemWidth = layout?.itemSize.width ?? 120 //screenWidth - (contentInset.left * 2)
        let itemHeight = layout?.itemSize.height ?? 190
        //print(collectionViewFlowLayout.itemSize)
        //return collectionViewFlowLayout.itemSize 
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewContentInset
    }
}

