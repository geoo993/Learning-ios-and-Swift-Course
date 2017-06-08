//
//  StorySmartiesBookShelfCollectionViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit


class StorySmartiesBookShelfCollectionViewController: UICollectionViewController {

    //Mark: - Collection view 
    @IBOutlet var bookshelfCollectionView: UICollectionView!
    
    private let bookshelfreuseIdentifier = "book shelf cell"
    private let pagesSegueIdentifier = "pages segue"
    
    private var revealviewcontroller : SWRevealViewController!
    private var pagesViewController : StorySmartiesViewController? 
    
    
    func setupPagesViewController (){
    
        //let bundleIdentifier =  Bundle.main.bundleIdentifier
        let defaultBundleID = "co.lexilabs.LearningSwiftCourse"
        let bundle = Bundle(identifier: defaultBundleID)
        let storyboard = UIStoryboard(name: "StorySmartiesMain", bundle: bundle) 
        pagesViewController = storyboard.instantiateViewController(withIdentifier: "StorySmartiesViewController") as? StorySmartiesViewController
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        revealviewcontroller = self.revealViewController()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(StorySmartiesBookShelfCollectionViewCell.self, forCellWithReuseIdentifier: bookshelfreuseIdentifier)

        // Do any additional setup after loading the view.
        setupPagesViewController()
        
        if revealviewcontroller != nil {
            revealviewcontroller.rearViewRevealWidth = 200
            //            menuButton.target = revealViewController()
            //            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealviewcontroller.panGestureRecognizer())
        }else{
            print("reveal is nil")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookshelfreuseIdentifier, for: indexPath) as? StorySmartiesBookShelfCollectionViewCell else {
            
            return StorySmartiesBookShelfCollectionViewCell()
        }
        cell.backgroundColor = UIColor.randomColor()
        
//        cell.bookShelfImageView.image = UIImage(named: "The_Tale_of_Peter_Rabbit") ?? UIImage(named: "noimage")  ?? UIImage()
//        //cell.addSubview(view: UIView)
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
     */
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
  
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        revealviewcontroller.pushFrontViewController(pagesViewController!, animated: true)
        
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
    
    deinit {
        pagesViewController = nil
        print("Book Shelf collection controller is \(#function)")
    }

}

