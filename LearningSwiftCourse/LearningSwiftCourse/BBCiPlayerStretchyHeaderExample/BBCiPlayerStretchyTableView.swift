//
//  BBCiPlayerStretchyTableView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 27/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class BBCiPlayerStretchyTableView: UITableView {

    var tableViewDissmissViewController : () -> Void = {}
    var tableViewShouldOpenPanel : () -> Void = {}
    
    @IBOutlet weak var topNavBar : UINavigationBar!
    @IBOutlet weak var bottomNavBar : UINavigationBar!
    @IBOutlet weak var bottomNavBarUpArrowIcon : UIImageView!
    
    @IBOutlet weak var categoriesCollectionView : UICollectionView!
    @IBOutlet weak var channelsCollectionView : UICollectionView!
    
    
    @IBAction func menubuttonAction(_ sender: UIBarButtonItem) {
        print("menu")
        tableViewShouldOpenPanel()
    }
    
    @IBOutlet weak var homebutton: UIButton!
    @IBAction func homebuttonAction(_ sender: UIButton) {
        updateButtonColor(with: sender)
        tableViewDissmissViewController()
    }
    
    @IBOutlet weak var tvguidebutton: UIButton!
    @IBAction func tvguidebuttonAction(_ sender: UIButton) {
      updateButtonColor(with: sender)
    }
    
    @IBOutlet weak var programmesbutton: UIButton!
    @IBAction func programmesbuttonAction(_ sender: UIButton) {
       updateButtonColor(with: sender)
    }
    
    @IBOutlet weak var downloadsbutton: UIButton!
    @IBAction func downloadsbuttonAction(_ sender: UIButton) {
        updateButtonColor(with: sender)
    }
    
    func updateButtonColor(with sender: UIButton){
        
        let buttons =  getAllTopButtons()
        for button in buttons {
            button.tintColor = UIColor.white
            button.setTitleColor(.white, for: .normal)
        }
        sender.tintColor = UIColor.bbciplayerPink
        sender.setTitleColor(.bbciplayerPink, for: .normal)
    }
    
    var allTopButtons = [UIButton]()
    func getAllTopButtons () -> [UIButton]
    {
        allTopButtons = [homebutton,tvguidebutton,programmesbutton,downloadsbutton]
        return allTopButtons
    }
    
    
    let categoriesItems = BBCiPlayerVideosItems.Categories.allCategories
    let channelsItems =  BBCiPlayerVideosItems.Channels.allChannels
    var categoriesLabels = [UILabel]()
    var collectionViewSpacing : CGFloat = 30
    
    /*
     override init(frame: CGRect) {
     super.init(frame: frame)
     
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
     override func awakeFromNib() {
        super.awakeFromNib()
        
        setupNavBars()
        
     }
     
     public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
     }

     
     public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateBottomNavBarVisibility()
     }
     
    func setupNavBars(){
        topNavBar.clearNavigationBarBackground(with: UIColor.clear)
        topNavBar.topItem?.leftBarButtonItem?.image = UIImage(named:"BBC_iPlayer_logo_white_nav")?.withRenderingMode(.alwaysOriginal) 
        
        bottomNavBar.clearNavigationBarBackground(with: UIColor.clear)
        bottomNavBar.topItem?.rightBarButtonItems?.last?.image = UIImage(named:"BBC_iPlayer_logo_white_nav")?.withRenderingMode(.alwaysOriginal)
    }
    
    func updateBottomNavBarVisibility (){
        
        let yPosition = self.frame.origin.y
        let difference = yPosition.percentageBetween(maxValue: -280, minValue: -284) / 100
        bottomNavBar.alpha = 1 - abs(difference)
        bottomNavBarUpArrowIcon.alpha = abs(difference)
        bottomNavBar.isHidden = (bottomNavBar.alpha < 0.05)
    }

    deinit {
        topNavBar = nil
        bottomNavBar = nil
        bottomNavBarUpArrowIcon = nil
    }
}


// MARK: UICollectionViewDataSource
extension BBCiPlayerStretchyTableView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if collectionView == categoriesCollectionView{
            return categoriesItems.count
        }
        
        if collectionView == channelsCollectionView{
            return channelsItems.count
        }
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView{
            guard let categorycell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryid", for: indexPath) as? BBCiPlayerStretchyCategoriesCollectionViewCell
                else {
                    return BBCiPlayerStretchyCategoriesCollectionViewCell()
            }
            categorycell.categoryLabel.text = categoriesItems[indexPath.row].rawValue
            return categorycell
        }
        
        if collectionView == channelsCollectionView{
            guard let channelcell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelid", for: indexPath) as? BBCiPlayerStretchyChannelsCollectionViewCell
                else {
                    return BBCiPlayerStretchyChannelsCollectionViewCell()
            }
            
            channelcell.channelLabel.text = ""//channelsItems[indexPath.row].channel.rawValue
            channelcell.channelImage.image = channelsItems[indexPath.row].image
            return channelcell
        }
        
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate


    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        collectionView.reloadData()
        return true
    }

    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.reloadData()
        return true
    }

    //did select item (cell) with tap gesture
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == categoriesCollectionView{
            guard let categorycell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryid", for: indexPath) as? BBCiPlayerStretchyCategoriesCollectionViewCell
                else { return }
            categorycell.specialHighlightedArea = UIView()
            categorycell.contentView.addSubview(categorycell.specialHighlightedArea!)
        }
        
        if collectionView == channelsCollectionView{
            guard let channelcell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelid", for: indexPath) as? BBCiPlayerStretchyChannelsCollectionViewCell
                else { return }
            channelcell.specialHighlightedArea = UIView()
            channelcell.contentView.addSubview(channelcell.specialHighlightedArea!)
        }
        
        
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension BBCiPlayerStretchyTableView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let textFont = UIFont.init(name: FamilyName.arialHebrewBold.rawValue , size: 14)
    
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = layout?.itemSize.width ?? 100
        let itemHeight = layout?.itemSize.height ?? 44
        
        if collectionView == categoriesCollectionView{
            //let size: CGSize = categoriesItems[indexPath.row].rawValue.size(withAttributes: [NSAttributedStringKey.font: textFont])
            let extimatedWidth = categoriesItems[indexPath.row].rawValue
                .width(withConstraintedHeight: itemHeight, font: textFont!)
            let categoryWidth = collectionViewSpacing + extimatedWidth //size.width
            return CGSize(width: categoryWidth, height: itemHeight)
        }
        
        if collectionView == channelsCollectionView{
            //let size: CGSize = channelsItems[indexPath.row].rawValue.size(withAttributes: [NSAttributedStringKey.font: textFont])
            let extimatedWidth = channelsItems[indexPath.row].channel.rawValue
                .width(withConstraintedHeight: itemHeight, font: textFont!)
            let channelWidth = collectionViewSpacing + extimatedWidth //size.width
            return CGSize(width: channelWidth, height: itemHeight)
        }
        
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero//contentInset
    }
}

// MARK: - UIScrollViewDelegate
extension BBCiPlayerStretchyTableView : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        
        if scrollView == categoriesCollectionView{
            //print("categories scrollview")
        }
        
        if scrollView == channelsCollectionView{
            //print("channels scrollview")
        }

    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //        if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
        //            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
        //        }
    }
    
}
 

