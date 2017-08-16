//
//  HomeCollectionViewController.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 13/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

//https://www.letsbuildthatapp.com/course_video?id=65
//https://www.letsbuildthatapp.com/course_video?id=66
//https://www.letsbuildthatapp.com/course_video?id=67

import Foundation
import UIKit


class YoutubeHomeCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "VideoCellId"

    let navBarHeight : CGFloat = 50
    
    let menusNames = ["Home", "Trending", "Subscriptions", "Account"]
    
    private func titleLabel() -> UILabel {
        let titleViewFrame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        let titleLabel = UILabel(frame: titleViewFrame)
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.backgroundColor = UIColor.clear
        
        return titleLabel
    }
    
    func setMenuTitle(with text: String){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(text)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = titleLabel()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupCollectionView(){
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        // Register cell classes
        collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      
        collectionView?.contentInset = UIEdgeInsets(top: navBarHeight, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: navBarHeight, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }

    lazy var menuBar : YoutubeMenuBar = {
        let mb = YoutubeMenuBar()
        mb.imageNames = self.menusNames
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.topMenuRedColor()
        view.addSubview(redView)
        view.addConstraints(with: "H:|[v0]|", views: redView)
        view.addConstraints(with: "V:[v0(50)]", views: redView) // Nav Bar Height
        
        view.addSubview(menuBar)
        view.addConstraints(with: "H:|[v0]|", views: menuBar)
        view.addConstraints(with: "V:[v0(50)]", views: menuBar) // Nav Bar Height
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    private func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon2")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchTapped))
        
        let optionImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: optionImage, style: .plain, target: self, action: #selector(moreTapped))
        
        navigationItem.rightBarButtonItems = [moreButtonItem, searchBarButtonItem]
    }
    
    @objc private func searchTapped(_ sender: UIBarButtonItem){
        print("search")
        scrollToMenuIndex(with: 2)
    }
    
    func scrollToMenuIndex(with index: Int){
        let selectedIndexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: selectedIndexPath, at: [], animated: true)
        setMenuTitle(with: menusNames[index])
    }
    
    @objc private func moreTapped(_ sender: UIBarButtonItem){
        print("more")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UICollectionViewDataSource
extension YoutubeHomeCollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / 4
        //if x > 0 && x < (view.frame.size.width - (view.frame.size.width / 4) ) {
            menuBar.horizontalbarLeftAnchorConstraint?.constant = x
        //}
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index : Int = Int(targetContentOffset.pointee.x / view.frame.width)
        menuBar.selectItem(with: index)
        setMenuTitle(with: menusNames[index])
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension YoutubeHomeCollectionViewController  {
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    
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
extension YoutubeHomeCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        //let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let screenWidth = view.frame.width
        return CGSize(width: screenWidth, height: view.frame.height - navBarHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}



