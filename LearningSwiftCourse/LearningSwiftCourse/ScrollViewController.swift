//
//  ScrollViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load slideInfo
        let info = LoadSlidesPropertyListFile()
        
        //set the page control numbers of pages
        pageControl.numberOfPages = info.count
        
        //set the scrollView properties
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        
        
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
            
            slide.titleLabel.text = slides[i].title
            slide.descriptionLabel.text = slides[i].description
            
            scrollView.addSubview(slide)
            slidesViews.append(slide)
            
        }
        
        
        //calculate the content width
        let contentWidth = UIScreen.main.bounds.size.width * CGFloat(slides.count)
        
        
        //set scrollView content size
        scrollView.contentSize = CGSize(width: contentWidth, height: UIScreen.main.bounds.size.height)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //This way the first slide will also begin to animate the Zoom effect
        scrollViewDidEndDecelerating(scrollView)
    }
    
    deinit {
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
        let currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width )
        pageControl.currentPage = currentPage
        
//        for i in 0..<slidesViews.count {
//            
//            UIView.animate(withDuration: 0.0, delay: 0.0, options: [.beginFromCurrentState],
//               animations: {[weak self] in
//                self?.slidesViews[i].backgroundImage.transform = CGAffineTransform.identity 
//            }, completion: { [weak self] _ in
//                guard let this = self else { return }
//                this.slidesViews[i].backgroundImage.layer.removeAllAnimations()
//                this.slidesViews[i].backgroundImage.layoutIfNeeded()
//            })
//            
//        }
     
        //zoom(currentPage)
    }
    
    func zoom (_ page:Int){
        
        //zoom in effect
        let imageView = slidesViews[page].backgroundImage
    
        UIView.animate(withDuration: 10.0, delay: 0.2, options: [.curveEaseInOut], animations: { 
            imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (isCompleted) in
            UIView.animate(withDuration: 10.0, delay: 0.2, options: [.curveEaseInOut], animations: { 
                imageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (isCompleted) in
                self.zoom(page)
            }
        }
        
    }
    
    //Parralax Effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let percent = Double(scrollView.contentOffset.x / scrollView.contentSize.width)
      
//        for i in 0..<slidesViews.count {
//            let slide = slidesViews[i]
//            let offset = Double(slide.backgroundImage.frame.size.width - UIScreen.main.bounds.size.width) / Double(slidesViews.count - 1)
//            slide.backgroundImage.frame.origin.x = CGFloat(-( (percent * offset) ))
//        }
        
    }
}
