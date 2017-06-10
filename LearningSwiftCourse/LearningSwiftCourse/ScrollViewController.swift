//
//  ScrollViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=w3AlRaYwEjg
//https://www.youtube.com/watch?v=8PWjo1Di620

import UIKit
import EasyAnimation

class ScrollViewController: UIViewController {

    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var animationChain : EAAnimationFuture?
    var previousPage : Int = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load slideInfo
        let info = LoadSlidesPropertyListFile()
        
        //set the page control numbers of pages
        pageControl.numberOfPages = info.count
        
        //set the scrollView properties
        mainScrollView.isPagingEnabled = true
        mainScrollView.bounces = false
        mainScrollView.delegate = self
        
        
        //Build Slides View
        setupSlides(info)
    }
    
    var slidesViews = [Slide]()
    func setupSlides(_ slides: [SlidesInfoModel]){
        
        //build our slides
        for i in 0..<slides.count {
            let slide = Slide(frame: CGRect(origin: CGPoint(), size: UIScreen.main.bounds.size))
            slide.index = i
            slide.frame.origin.x = CGFloat(i) * UIScreen.main.bounds.size.width
            
            if let img = UIImage(named: slides[i].imageName) {
                slide.backgroundImage.image = img
            }else{
                
                //let bundleIdentifier =  Bundle.main.bundleIdentifier
                let defaultBundleID = "co.lexilabs.LearningSwiftCourse"
                let bundle = Bundle(identifier: defaultBundleID)
                let gifImage = UIImage.gifImageWithName(name: slides[i].imageName, bundle: bundle)
                slide.backgroundImage.image = gifImage
                
            }
            
            slide.clipsToBounds = true
            slide.layer.masksToBounds = true
            slide.titleLabel.text = slides[i].title
            slide.descriptionLabel.text = slides[i].description
            
            mainScrollView.addSubview(slide)
            slidesViews.append(slide)
            
        }
        
        //calculate the content width
        let contentWidth = UIScreen.main.bounds.size.width * CGFloat(slides.count)
        
        
        //set scrollView content size
        mainScrollView.contentSize = CGSize(width: contentWidth, height: UIScreen.main.bounds.size.height)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //This way the first slide will also begin to animate the Zoom effect
        scrollViewDidEndDecelerating(mainScrollView)
    }
    
    func clearAll(){
        animationChain?.cancelAnimationChain()
        animationChain = nil
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Scroll view controller is \(#function)")
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

extension ScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        let currentPage = Int(mainScrollView.contentOffset.x / UIScreen.main.bounds.size.width )
        pageControl.currentPage = currentPage
        
        //zoom in effect
        let imageView = slidesViews[currentPage].backgroundImage
        
        animationChain = 
            UIView.animateAndChain(
                withDuration: 10.0, 
                delay: 0.2, 
                options: [.curveEaseInOut], 
                animations: {
                imageView?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                imageView?.layoutIfNeeded()
            }, completion: nil).animate(withDuration: 10.0, animations: {
                imageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        previousPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        for i in 0..<self.slidesViews.count {
            
            animationChain?.cancelAnimationChain({ [weak self] _ in
                guard let this = self else { return }
                let slide = this.slidesViews[i]
                slide.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                slide.layer.removeAllAnimations()
                slide.frame.origin.x = CGFloat(i) * UIScreen.main.bounds.size.width
                slide.layoutIfNeeded()
            })
            
            animationChain = nil
        }
        
    }
}
