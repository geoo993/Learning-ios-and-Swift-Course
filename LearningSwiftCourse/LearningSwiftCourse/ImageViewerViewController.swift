//
//  ImageViewerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/41972578/how-to-implement-xcode-swift3-uiscrollview-image-zooming
//https://stackoverflow.com/questions/38855581/zooming-into-an-image-from-users-touch-point-with-uiscrollview-in-swift
//https://github.com/villyg/PhotoSlideShow-Swift

import UIKit
import AVFoundation
import Cartography
import RxSwift

class ImageViewerViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var disposable = DisposeBag()
    
    var scrollView: UIScrollView?
    var pageControl: UIPageControl?
    
    var screenFrame = {
        return UIScreen.main.bounds
    }()
    
    var images : [UIImage] = [0..<10].flatMap{ $0 }.map{ UIImage(named: "slide\($0)")! }
    var slidesViews = [UIImageView]()
    var currentImageView: UIImageView?
    var currentPageIndex : Int = 0
    
    var tap: UITapGestureRecognizer?
    
    var scrollOffset = CGPoint.zero
    var totalPages: Int = 0
    var isZoomMode = false
    var shouldDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalPages = images.count
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       imageViewerSetup()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if scrollView != nil {
            //This way the first slide will also begin to animate the Zoom effect
            scrollViewDidEndDecelerating(scrollView!)
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
    }
    
    // MARK: Custom method implementation
    func imageViewerSetup(){
        
        clearArea()
        
        setScrollView()
        
        setPageControl(pages: totalPages)
        
        setScrollViewImages()
        
        setGestureRecognizer()
        
        addHomeButton()
    }
    
    func setScrollView(){
        
        view.removeEverything()
        
        if scrollView == nil {
            
            let frame = UIScreen.main.bounds
            scrollView = UIScrollView(frame: frame)
            scrollView?.showsHorizontalScrollIndicator = true
            scrollView?.showsVerticalScrollIndicator = false
            //scrollView?.isPagingEnabled = true
            scrollView?.isScrollEnabled = true
            scrollView?.isDirectionalLockEnabled = false
            scrollView?.bounces = false
            scrollView?.alwaysBounceHorizontal = false
            scrollView?.alwaysBounceVertical = false
            scrollView?.minimumZoomScale = 1.0
            scrollView?.maximumZoomScale = 1.0
            scrollView?.bouncesZoom = false
            scrollView?.scrollIndicatorInsets = UIEdgeInsets.zero
            scrollView?.isUserInteractionEnabled = true
            scrollView?.clipsToBounds = true
            scrollView?.layer.masksToBounds = true
            scrollView?.decelerationRate = UIScrollViewDecelerationRateFast
            scrollView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            scrollView?.backgroundColor = UIColor.black
            scrollView?.decelerationRate = UIScrollViewDecelerationRateNormal//scroll view speed
            scrollView?.delegate = self 
            
            view.addSubview(scrollView!)
            
            constrain(scrollView!) { view1 in
                view1.center == view1.superview!.center
                view1.top == view1.superview!.top 
                view1.bottom == view1.superview!.bottom 
                view1.trailing == view1.superview!.trailing
                view1.leading == view1.superview!.leading
            }
            
        }
    }
    
    func setPageControl(pages: Int){
        
        if pageControl == nil {
            
            pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
            pageControl?.numberOfPages = pages
            pageControl?.currentPage = 0
            pageControl?.translatesAutoresizingMaskIntoConstraints = false
            pageControl?.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.6)
            pageControl?.currentPageIndicatorTintColor = UIColor.white
            pageControl?.tintColor = UIColor.red
            
            view.insertSubview(pageControl!, at: 0)
            view.bringSubview(toFront: pageControl!)
            
            
            constrain(pageControl!) { view1 in
                view1.centerX == view1.superview!.centerX
                view1.height == 20
                view1.bottom == view1.superview!.bottom - 10
            }
            
        }
        
        pageControl?.currentPage = currentPageIndex
        
    }
    
    func setScrollViewImages(){
        
        
        for i in 0..<totalPages {
            
            let xPos = CGFloat(i) * screenFrame.size.width
            let frame = CGRect(origin: CGPoint(x:xPos,y:0), size: screenFrame.size)
            let imageView = UIImageView(frame: frame )
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.masksToBounds = true
            imageView.isUserInteractionEnabled = true
            
            scrollView?.addSubview(imageView)
            slidesViews.append(imageView)
        }
        
        calculateContentSize()
        
        calculateContentOffset(withIndex: currentPageIndex)
        
    }
    
    func calculateContentSize(){
        let contentWidth = screenFrame.size.width * CGFloat(totalPages)
        
        scrollView?.contentSize = CGSize(width: contentWidth, height: screenFrame.size.height)
    }
    
    func calculateContentOffset(withIndex at: Int){
        let xPosition = CGFloat(at) * screenFrame.size.width
        let scrollOffset = CGPoint(x: xPosition, y: 0)
        scrollView?.contentOffset = scrollOffset
        scrollView?.contentInset = UIEdgeInsets.zero
    }

    func setGestureRecognizer()
    {
        tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tap?.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap!)
    }

    func handleDoubleTap(_ recognizer: UITapGestureRecognizer)
    {
        
        isZoomMode = !isZoomMode
        
        if isZoomMode {
            
            currentImageView = scrollView?.subviews.first(where: { $0 == slidesViews[currentPageIndex] }) as? UIImageView
            
            
            //let touchPoint = recognizer.location(in: view)
            //let touchPointRelativeToScrollView = view.convert(touchPoint, to: scrollView)
            
            if let image = currentImageView?.image
                //, let selectedImageFrame = currentImageView?.frame 
            {
                
                //let customFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50))
                /*
                var createView = UIView(frame: selectedImageFrame)
//                //createView.center = touchPointRelativeToScrollView
                createView.backgroundColor = UIColor.red
                createView.tag = 10
                scrollView?.addSubview(createView)
                */
                
                shouldDismiss = false
                
                clearArea()
                
                let scrollView: ImageScrollView = ImageScrollView(frame: screenFrame, shouldFillView: true)
                self.view = scrollView
                scrollView.displayImage(image)
                
                setGestureRecognizer()
                
            }
            
        }else{
            
            
            imageViewerSetup()
        }
        
    }
  
    func removeImage(with tag:Int, index:Int){
        
        //remove image with tag
        _ = scrollView?.subviews.map { $0.viewWithTag(tag)?.removeFromSuperview()}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func addHomeButton (){
        
        shouldDismiss = true
        
        let homeButton = UIButton(type: .system)
        homeButton.setTitle("Home", for: .normal)
        homeButton.backgroundColor = UIColor.clear
        view.addSubview(homeButton)
      
        homeButton.rx.tap.subscribe { [weak self] tap in
            
            if self?.shouldDismiss == true {
                self?.dismiss(animated: true) { 
                    print("view controller dismissed, now going to home page")
                }
            }
        }.addDisposableTo(disposable)
        
        constrain(homeButton) { view1 in
            view1.centerX == view1.superview!.centerX
            view1.height == 30
            view1.top == view1.superview!.top + 20
        }
        
    }
    
    func clearArea(){
        view.removeEverything()
        scrollView = nil
        pageControl = nil
        slidesViews.removeAll()
    }
    
    
    deinit {
        clearArea()
        print("Image Viewer view controller is \(#function)")
    }
    
}

// MARK: UIScrollViewDelegate method implementation
extension ImageViewerViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let xPosition = self.scrollView?.contentOffset.x {
            
            // Calculate the new page index depending on the content offset.
            currentPageIndex = Int( xPosition / screenFrame.size.width )
            //1.025 = 328/320
            // Set the new page index to the page control.
            pageControl?.currentPage = currentPageIndex
        
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        scrollOffset = targetContentOffset.pointee
        let currentImageWidth = screenFrame.size.width 
        
        let index = (scrollOffset.x + scrollView.contentInset.left) / currentImageWidth
        let roundedIndex = round(index)
        
        let xPosition = roundedIndex * currentImageWidth - (scrollView.contentInset.left)
        let yPosition = -scrollView.contentInset.top
        scrollOffset = CGPoint(x: xPosition, y: yPosition)
        
        targetContentOffset.pointee = scrollOffset
        
    }
    
}
