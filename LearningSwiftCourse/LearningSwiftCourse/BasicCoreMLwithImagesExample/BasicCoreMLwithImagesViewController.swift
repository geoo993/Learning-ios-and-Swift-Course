//
//  ViewController.swift
//  BasicCoreML
//
//  Created by Brian Advent on 09.06.17.
//  Copyright © 2017 Brian Advent. All rights reserved.
//
//https://www.youtube.com/watch?v=cyWYTwDtbyw
//https://www.youtube.com/watch?v=NNKPbdT9gXU

import UIKit

class BasicCoreMLwithImagesViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    
    let googleNetPlacesModel = GoogLeNetPlaces()
    private let reuseIdentifier = "imagesCollectionCell"
    var images : [UIImage?] = [0..<16].flatMap{ $0 }.map{ UIImage(named: "img\($0 + 1)")! }
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func sceneLabel(forImage image: UIImage) -> String?
    {
        //requires to pass along a CVPixelBuffer
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image) {
            guard let scene = try? googleNetPlacesModel.prediction(sceneImage: pixelBuffer) else { return nil }
            return scene.sceneLabel
        }
        
        return nil
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
    
    deinit {
        print("BasicCoreML With Images view controller is \(#function)")
    }
    

}


    // MARK: UICollectionViewDataSource
extension BasicCoreMLwithImagesViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BasicCoreMLwithImagesCollectionViewCell 
            else {
                return BasicCoreMLwithImagesCollectionViewCell()
        }
        
        cell.cellImageView.image = images[indexPath.row]
        
        return cell
    }
}

    // MARK: UICollectionViewDelegate
extension BasicCoreMLwithImagesViewController : UICollectionViewDelegate {
    
    
    
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
        
        if let imageToAnalyse = images[indexPath.row] {
            if let sceneLabelString = sceneLabel(forImage: imageToAnalyse) {
                categoryLabel.text = sceneLabelString
            }
        }
   
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




