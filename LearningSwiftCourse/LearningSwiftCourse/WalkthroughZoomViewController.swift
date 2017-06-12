//
//  WalkthroughZoomViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/3967971/how-to-zoom-in-out-photo-on-double-tap-in-the-iphone-wwdc-2010-104-photoscroll
//https://stackoverflow.com/questions/41972578/how-to-implement-xcode-swift3-uiscrollview-image-zooming
//https://stackoverflow.com/questions/10759872/how-to-get-the-image-to-zoom-where-i-double-tapped
//https://stackoverflow.com/questions/9008975/how-to-tap-to-zoom-and-double-tap-to-zoom-out-in-ios

import UIKit
import Cartography
import RxSwift

class WalkthroughZoomViewController: UIViewController {

    var scrollView: ImageScrollView? 
    var image : UIImage?
    var disposable = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let img = image {
            
            scrollView = ImageScrollView(frame: self.view.frame, shouldFillView: true, additionalScale: 2)
            self.view = scrollView
            scrollView?.displayImage(img)
            
            setupGestureRecognizer()
        }
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
   
    
    func setupGestureRecognizer()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func handleDoubleTap(_ recognizer: UITapGestureRecognizer)
    {
        
        
        if ((scrollView?.zoomScale)! > (scrollView?.minimumZoomScale)!)
        {
            scrollView?.setZoomScale((scrollView?.minimumZoomScale)!, animated: true)
        } else {
            //scrollView?.setZoomScale((scrollView?.maximumZoomScale)!, animated: true)
            
            let touchPoint = recognizer.location(in: scrollView?._imageView)
            //let touchPointRelativeToScrollView = view.convert(touchPoint, to: scrollView)
            
            if let scrollViewSize = scrollView?.bounds.size {
                
                let w = scrollViewSize.width / (scrollView?.maximumZoomScale)!
                let h = scrollViewSize.height / (scrollView?.maximumZoomScale)! 
                let x = touchPoint.x - (w/2.0)
                let y = touchPoint.y - (h/2.0)
                
                //print(touchPoint, x, y)
                
                let rect = CGRect(x:x,y: y, width:w, height:h)
                scrollView?.zoom(to: rect, animated: true)
                
            }
        }
 
        
        
        
    }

    func handleSwipe(_ recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.direction == UISwipeGestureRecognizerDirection.down{
            self.dismiss(animated: true) { 
                print("view controller dismissed, now going to home page")
            }
        }
        
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

    func clearAll(){
        view.removeEverything()
        scrollView = nil
    }
    
    deinit {
        clearAll()
        print("Walktrough zoom view controller is \(#function)")
    }
    
}
