//
//  MainCollectionViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit


private let reuseIdentifier = "MainCell"

@IBDesignable
class MainCollectionViewController: UICollectionViewController {
  
    //let customPresentAnimationController = CustomPresentAnimationController()
    //let customDismissAnimationController = CustomDismissAnimationController()
    
    var views: [String: String] = [
                           //"StorySmartiesRevealViewController":"StorySmartiesMain",
                           //"VideoPlayerViewController":"VideoPlayerMain",
                           //"AudioCheckViewController": "AudioMain",
                           //"TableViewNavigationViewController": "TableViewMain",
                           //"TabBarViewController": "TabBarMain",
                           //"NavigationViewController": "NavBarMain",
                           //"ColorsViewController": "ColorsMain",
                           //"ScrollViewController": "ScrollViewMain",
                           //"CustomPageViewController" : "PageViewMain",
                           "SlideShowViewController" : "SlideShowMain",
                           //"ParallaxHeaderTableViewController" : "ParallaxHeaderMain",
                           "ParallaxViewController" : "ParallaxMain",
                           "ImageViewerViewController" : "ImageViewerMain",
                           //"ImageCropperViewController" : "ImageCropperMain",
                           //"ImagePickerCoreMLViewNavigationController" : "ImagePickerCoreMLViewMain", 
                           //"CarouselViewController": "CarouselMain",
                           "InspirationalFilmsViewController": "InspirationalFilmsMain",
                           //"AirbnbRevealViewController" : "AirbnbMain",
                           //"PopUpNavigationController": "PopUpMain",
                           //"SideBarMenuViewController" : "SideBarMenuMain",
                           //"SWRevealViewController" : "MultiSidedBarMenuMain",
                           //"/Users/GeorgeQuentin/Dev/Learning-ios8-and-Swift-Course/LearningSwiftCourse/LearningSwiftCourse/Student Submissions for the WWDC 2017 ScholarshipTopMenuNavigationController" : "TopMenuMain",
                           //"DraggableTopMenuMainViewController" : "DraggableVerticalMenusMain",
                           //"SpringBasedDrawerViewController" : "SpringBasedDrawerMain",
                           //"ButtonsTypesViewController": "ButtonsMain",
                           //"BasicCoreMLwithImagesViewController" : "BasicCoreMLwithImagesMain",
                           "SliderMenuDrawerNavigationController" : "SliderMenuDrawerMain",
                            //"SearchBarViewNavigationController" : "SearchBarMain",
                            //"StretchyHeaderRevealViewController" : "StretchyHeaderMain",
                            //"BBCiPlayerTableViewController" : "BBCiPlayerMain",
                            //"SimpleSpringDrawerViewController" : "SimpleSpringDrawerMain",
                            //"BBCiPlayerStretchyHeaderViewController" : "BBCiPlayerStretchyHeaderMain",
                            //"UIPickerViewController" : "UIPickerMain",
                            "UIViewSlidesViewController" : "UIViewSlidesMain",
                            "AnimatableSideMenuContainerViewController" : "AnimatableSideMenuMain",
                            "PieChartPageViewController" : "CirclePieViewMain",
                            //"CarthageDemoViewController" : "CarthageDemoMain",
                            "AninmationsWithLottieViewController" : "AninmationsWithLottieMain",
                            "ButtonWithImageAndTextViewController" : "ButtonWithImageAndTextMain",
                            "RadialMenuTabBarController" : "RadialMenuMain",
                            "CircleMenuViewController" : "CircleMenuMain",
                           ]
    
    //Mark: - Collection view 
    @IBOutlet var mainCollectionView: UICollectionView!
    
    
    //Mark: - Set cell width and content inset
    var cellColorName = [String]()
    var contentInset = UIEdgeInsets(top: 40, left: 10, bottom: 0, right: 10) 
    var screenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        cellColorName = UIColor.cssString.take(views.count)
        
    }
    
    /*
    func findAllControllers()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let viewControllers = appDelegate.window?.rootViewController?.presentedViewController
        {
            // Array of all viewcontroller even after presented
        }
        else if let viewControllers = appDelegate.window?.rootViewController?.childViewControllers
        {
            // Array of all viewcontroller after push  
            viewControllers.flatMap{ print($0) }
        }
        
    }
 */
    
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return views.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell 
            else {
            return MainCollectionViewCell()
        }
        
        let color = UIColor(hex: cellColorName[indexPath.row])
        cell.backgroundColor = color
        
        cell.cellImageView.backgroundColor = color
        cell.cellImageView.image = UIImage(named: "AppGameIcon") ?? UIImage()
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    //did select item (cell) with tap gesture
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        //let bundleIdentifier =  Bundle.main.bundleIdentifier
        let defaultBundleID = "co.lexilabs.LearningSwiftCourse"
        let bundle = Bundle(identifier: defaultBundleID)
        let view = views.getKeyString(index: indexPath.row)
        if let storyBoardName = views[view] { 
        
            let storyboard = UIStoryboard(name: storyBoardName, bundle: bundle) 
            let vc = storyboard.instantiateViewController(withIdentifier: view)
            //vc.transitioningDelegate = self
            present(vc, animated: true, completion: nil)
            
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

    
    deinit {
        print("Main view controller is \(#function)")
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = layout?.itemSize.width ?? 120 //screenWidth - (contentInset.left * 2)
        let itemHeight = layout?.itemSize.height ?? 100
        
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return contentInset
    }
}

/*
extension MainCollectionViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customPresentAnimationController.duration = 2.0
        customPresentAnimationController.reverseSide = true
        return customPresentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customDismissAnimationController
    }
}
 */
