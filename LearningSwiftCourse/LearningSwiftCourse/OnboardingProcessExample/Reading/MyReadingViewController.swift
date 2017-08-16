//
//  MyReadingViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift

class MyReadingViewController: UIViewController {

    let reuseIdentifier = "mySectionCell"
    
    @IBOutlet weak var sectionsCollectionView : UICollectionView!
    @IBOutlet weak var menuBar : MyReadingMenuBar!
    
    let didCompleteBookSelection = PublishSubject<String>()
    
    let menusNames = ["To Read", "Reading", "Read"]
    let menusReadingButton = ["Start reading", "Continue reading", "Read again"]
    
    var selectedBooks : [String]?
    var navBarHeight : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMenuBar()
        
    }
    
    func setupCollectionView() {
        sectionsCollectionView?.backgroundColor = UIColor.white
    }
    
    func setupMenuBar(){
        menuBar.myReadingController = self
        menuBar.selectItem(with: 1)
        scrollToMenuIndex(with: 1)
    }
    
    func scrollToMenuIndex(with index: Int){
        let selectedIndexPath = IndexPath(item: index, section: 0)
        sectionsCollectionView?.scrollToItem(at: selectedIndexPath, at: [], animated: true)
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
extension MyReadingViewController: UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / CGFloat(menusNames.count) 
        menuBar.horizontalbarLeftAnchorConstraint?.constant = x 
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index : Int = Int(targetContentOffset.pointee.x / view.frame.width)
        menuBar.selectItem(with: index)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return menusNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyReadingSectionsCollectionViewCell
        
        let index = indexPath.item
        cell.myReadingController = self
        cell.selectedBooks = selectedBooks ?? []
        cell.readingTitle = menusReadingButton[index]
        
        return cell
    }

}


// MARK: UICollectionViewDelegate
extension MyReadingViewController : UICollectionViewDelegate {
    
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
extension MyReadingViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let itemWidth : CGFloat = view.frame.width
        let itemHeight : CGFloat = view.frame.height -  menuBar.frame.height - navBarHeight
        
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
}
