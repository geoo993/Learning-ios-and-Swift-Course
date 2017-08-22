//
//  OnboardingBookSelectionViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift

class OnboardingBookSelectionViewController: UIViewController {

    let reuseIdentifier = "selectionViewCell"
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    let didCompleteBooksSelection = PublishSubject<[String]>()
    
    var books = [0..<20].flatMap{ $0 }.map{ "Book\($0)" } 
    
    var selectedColor = UIColor.green
    var uncheckedColor = UIColor.red
    
    var selectedIndexes = [Int]()
    
    lazy var booksSelected : [String] = {
        return self.selectedIndexes.map { "Book\($0)" }
    } ()
    
    @IBAction func skipButtonAction(_ sender : UIButton){
         didCompleteBooksSelection.onNext(booksSelected)
    }
    
    @IBAction func myReadingButtonAction(_ sender : UIButton){
         didCompleteBooksSelection.onNext(booksSelected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
    }

    func updateSelection(with selectedIndex : Int) {
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        if let cell = collectionView?.cellForItem(at: indexPath) as? OnboardingBookSelectionViewCell  {
            
            if selectedIndexes.contains(selectedIndex) {
                if let index = selectedIndexes.index(of: selectedIndex) {
                    selectedIndexes.remove(at: index)
                    cell.isItemSelected = false
                }
            }else{
                selectedIndexes.append(selectedIndex)
                cell.isItemSelected = true
            }
        }
    }
    
    func selectItem(with index: Int){
        // Select
        let selectedIndexPath = IndexPath(item: index, section: 0)
        collectionView?.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
        //collectionView(collectionView, didSelectItemAt: selectedIndexPath) 
    }
    
    func deselectItem(with index: Int){
        // Deselect
        let deselectedIndexPath = IndexPath(item: index, section: 0)
        collectionView?.deselectItem(at: deselectedIndexPath, animated: true)
        //collectionView(collectionView, didDeselectItemAt: deselectedIndexPath)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    
// MARK: UICollectionViewDataSource
extension OnboardingBookSelectionViewController : UICollectionViewDataSource { 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? OnboardingBookSelectionViewCell 
            else {
                return OnboardingBookSelectionViewCell()
        }
        
        let index = indexPath.item
        cell.isItemSelected = selectedIndexes.contains(index)
        cell.titleLabel.text = books[index]
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension OnboardingBookSelectionViewController : UICollectionViewDelegate {  
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //did select item (cell) with tap gesture
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelection(with: indexPath.item)
    }
}

