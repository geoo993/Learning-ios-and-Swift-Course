//
//  CarouselViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {

    //Mark: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    
    //Mark: - UICollectionviewDataSource
    var interests = Interest.createInterest()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct StoryBoard{
        static let cellIdentifier = "Interest Cell"
    }
}

extension CarouselViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cellIdentifier, for: indexPath) as? InterestCollectionViewCell else {
            return InterestCollectionViewCell()
        }
        
        cell.isUserInteractionEnabled = true
        cell.interest = interests[indexPath.item]
        
        return cell
    }
}
