//
//  WalkthroughViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//


import UIKit

class WalkthroughPageViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {//Touch Up Inside action
      
        //getNextViewController()
    }
    
    @IBOutlet weak var homeButton: UIButton!
    @IBAction func homeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
  
    var headerText = ""
    var imageName = ""
    var pageIndex: Int = -1
    var numberOfPages = 0
    
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupPage()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupPage(){
        
        headerLabel.text = headerText
        
        imageView.image = UIImage(named: imageName)
        
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = pageIndex
        
        homeButton.isEnabled = (pageIndex == 0) ? true : false
        homeButton.isHidden = (pageIndex == 0) ? false : true
    
        setupGestureRecognizer()
    }

    func getNextViewController(){
        let pageViewController = self.parent as! CustomPageViewController 
        _ = pageViewController.nextPageViewController(withIndex: pageIndex)
    }
    
    func getPreviousViewController(){
        let pageViewController = self.parent as! CustomPageViewController 
        _ = pageViewController.previousPageViewController(withIndex: pageIndex)
    }
    
    func setupGestureRecognizer()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    func handleDoubleTap(_ recognizer: UITapGestureRecognizer)
    {
        
        let zoomVC = self.storyboard!.instantiateViewController(withIdentifier: "WalkthroughZoomViewController") as! WalkthroughZoomViewController
        
        zoomVC.image = imageView.image
        self.present(zoomVC, animated: true, completion: { 
            print("Walktrough Zoom view controller presented")
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            
            if identifier == "enter zoom"{
                
                guard let destinationViewController = segue.destination as? WalkthroughZoomViewController else { 
                    print("Cannot go to Walkthrough Zoom View Controller or index path is wrong"); return 
                }
                
                destinationViewController.image = imageView.image
                
            }
        }
        
        
    }
    
    
    deinit {
        print("Walktrough page view controller is \(#function)")
    }

}
