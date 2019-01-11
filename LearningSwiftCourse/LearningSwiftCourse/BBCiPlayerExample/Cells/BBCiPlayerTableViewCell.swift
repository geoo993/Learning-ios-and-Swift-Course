//
//  BBCiPlayerTableViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class BBCiPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    fileprivate var collectionViewContentInset = UIEdgeInsets.zero 
    var cellLineSpacing : CGFloat! 
    var cellVerticalInsect : CGFloat! {
        willSet{
            collectionViewContentInset = UIEdgeInsets(top: newValue, left: 2, bottom: newValue, right: 2)
        }
    }
    var collectionViewCellHeight : CGFloat?
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setCollectionViewLayout(){
      
        //Get device width
        let screen = UIScreen.main.bounds
        
        //set section inset as per your requirement.
        collectionViewFlowLayout.sectionInset = collectionViewContentInset
        
        //set cell item size here 
        let itemWidth = ( (screen.size.width - (cellLineSpacing * 2) ) / 2 ) - 2
        let itemHeight = collectionViewCellHeight ?? 190
        collectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        //set Minimum spacing between 2 items
        collectionViewFlowLayout.minimumInteritemSpacing = cellLineSpacing
        
        //set minimum vertical line spacing here between two lines in collectionview
        collectionViewFlowLayout.minimumLineSpacing = cellLineSpacing 
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = collectionViewFlowLayout
    }
    
    deinit {
        collectionView = nil
        collectionViewFlowLayout = nil
        collectionViewCellHeight = nil
        cellLineSpacing = nil
        cellVerticalInsect = nil
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
        
        let captionText = collectionData[indexPath.row].caption.rawValue
        cell.imageHeadingLabel.text = captionText
        cell.imageHeadingLabel.backgroundColor = (captionText == "") ? UIColor.clear : UIColor.bbciplayerPink
            
        cell.imageHeadingView.image = collectionData[indexPath.row].image
        cell.titleLabel.text = collectionData[indexPath.row].title 
        cell.descriptionLabel.text = collectionData[indexPath.row].summary
        cell.backgroundColor = UIColor.bbciplayerDark
        
        return cell
    }
}

extension BBCiPlayerTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let bundle = Bundle(identifier: "co.lexilabs.LearningSwiftCourse")
        let storyboard = UIStoryboard(name: "BBCiPlayerMain", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "BBCiPlayerContentDetailedViewController") as! BBCiPlayerContentDetailedViewController
        
        //self.navigationController?.pushViewController(vc!, animated: true)
        let parentViewController = self.getParentViewController()
        vc.usingNavigationController = false
        vc.currentContent = collectionData[indexPath.row]
        parentViewController?.present(vc, animated: true, completion: { 
            print("BBCiPlayerContentDetailedViewController presented")
        })
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BBCiPlayerTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let screen = UIScreen.main.bounds
        //let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = ( (screen.size.width - (cellLineSpacing * 2) ) / 2 ) - 2
        //let itemWidth = layout?.itemSize.width ?? 120 //screenWidth - (contentInset.left * 2)
        let itemHeight = collectionViewCellHeight ?? 190
        //print(collectionViewFlowLayout.itemSize)
        //return collectionViewFlowLayout.itemSize 
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewContentInset
    }
    
}

