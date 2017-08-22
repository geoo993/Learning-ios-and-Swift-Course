//
//  FeedCell.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    private let feedIdentifier = "VideoCellId"
    
    var videos : [YoutubeVideo]? 
    
    var defaultVideos : [YoutubeVideo] = {
        let kanyeChanel = Channel(name:"KanyeWestVEVO",profileImageName:"kanye_profile" )
        let taylorSwiftChannel = Channel(name:"TaylorSwiftVEVO",profileImageName:"taylor_swift_profile" )
        let siaChannel = Channel(name:"SiaVEVO",profileImageName:"sia_profile" )
        
        return [
            YoutubeVideo(title: "Taylor Swift - Blank Space", numberOfViews : 2130046266,thumbnailImageName: "taylor_swift_blank_space", uploadDate : "2 years ago",duration: 210, channel : taylorSwiftChannel),
            YoutubeVideo(title: "Taylor Swift - Bad Blood ft. Kendrick Lamar", numberOfViews : 1099570742,thumbnailImageName: "taylor_swift_bad_blood",  uploadDate : "2 years ago", duration: 210,channel : taylorSwiftChannel),
            YoutubeVideo(title: "Sia - Chandelier",  numberOfViews : 1647463699,thumbnailImageName: "sia_chandelier", uploadDate : "3 years ago", duration: 210,channel : siaChannel),
            YoutubeVideo(title: "Kanye West - POWER", numberOfViews : 94533846, thumbnailImageName: "kanye_power",  uploadDate : "7 years ago", duration: 210,channel : kanyeChanel),
            YoutubeVideo(title: "Taylor Swift - Shake It Off", numberOfViews : 2319599468, thumbnailImageName: "taylor_swift_shake_it_off",  uploadDate : "2 years ago", duration: 210,channel : taylorSwiftChannel),
            YoutubeVideo(title: "Sia - The Greatest", numberOfViews : 475690296,thumbnailImageName: "sia_the_greatest", uploadDate : "11 months ago",duration: 210, channel : siaChannel),
            YoutubeVideo(title: "Sia - Cheap Thrills (Lyric Video) ft. Sean Paul", numberOfViews : 898328684, thumbnailImageName: "sia_cheap_thrills",  uploadDate : "1 year ago", duration: 210,channel : siaChannel),
        ]
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:50,height: 50)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout )
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self 
        cv.dataSource = self 
        return cv
    }()
    
    func setupCollectionView(){
        
        addSubview(collectionView)
        addConstraints(with: "H:|[v0]|", views: collectionView)
        addConstraints(with: "V:|[v0]|", views: collectionView)
        
        // Register cell classes
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: feedIdentifier)
        
    }
    
    func fetchVideos(){
        AppService.sharedInstance.fetchVideos { [weak self] (videos : [YoutubeVideo]) in
            self?.videos = videos
            self?.collectionView.reloadData()
        } 
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.random
        
        fetchVideos()
        
        setupCollectionView()
    }
}

// MARK: UICollectionViewDataSource
extension FeedCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return videos?.count ?? defaultVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedIdentifier, for: indexPath) as! VideoCell
        if let vids = videos {
            cell.isFromURL = true
            cell.video = vids[indexPath.item]
        }else {
            cell.isFromURL = false
            cell.video = defaultVideos[indexPath.item]
        }
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension FeedCell : UICollectionViewDelegate {
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
extension FeedCell : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        //let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let screenWidth = frame.width
        let topSpacing : CGFloat = 16
        let leftSpacing : CGFloat = 16
        let rightSpacing : CGFloat = 16
        let bottomArea : CGFloat = 92
        let ratio : CGFloat = 9 / 16
        let itemWidth = screenWidth //layout?.itemSize.width 
        let itemHeight = (itemWidth - leftSpacing - rightSpacing) * ratio
        return CGSize(width: itemWidth , height: itemHeight + topSpacing + bottomArea) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
    
}
