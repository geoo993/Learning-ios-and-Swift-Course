//
//  SlideShowView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

class SlideShowView: UIView {

    var currentImageindex = 0
    var parentView = UIView()
    var images : [UIImage] = []
    var imagesList = [UIImageView]()
    var imageTag = 1
    var duration : Double = 10
    var moveToDistance : Double = 50
    
    init(frame: CGRect, parentView: UIView, images: [UIImage]){
        super.init(frame: frame)
        
        self.parentView = parentView
        self.images = images
        
        addImage(with: imageTag, alpha: 0.0) 
        addImage(with: imageTag, alpha: 1.0) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func addImage(with tag:Int, alpha: CGFloat, inFront: Bool = false){
        
        //update images indexes
        currentImageindex = (currentImageindex + 1) % images.count
        
        //create new UIimageView
        let imageView = UIImageView(frame: self.frame)
        imageView.center = self.center
        imageView.image = images[currentImageindex]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = alpha
        imageView.isUserInteractionEnabled = false
        imageView.tag = tag
        if inFront {
            imagesList.insert(imageView, at: 0)
        }else{
            imagesList.append(imageView)
        }
        self.addSubview(imageView)
        
        //increment tags
        imageTag += 1
        
    }
    
    func removeImage(with tag:Int, index:Int){
        
        //remove image with tag
        _ = parentView.subviews.map { $0.viewWithTag(tag)?.removeFromSuperview()}
        imagesList.remove(at: index)
    }
    
    func moveTo (imageView : UIImageView, pathLength : Double) -> CGPoint {
        
        let piFactor = Double.pi / 180
        let angle = Double.random(min: 0, max: 360) // direction in which you need to move it
        
        ////new point coordinates of imageView to animate
        //// pathLength is total distance view should move
        let xCoord = imageView.center.x +  CGFloat(pathLength * sin(piFactor*angle)) 
        let yCoord = imageView.center.y +  CGFloat(pathLength * cos(piFactor*angle))
        
        return CGPoint(x: xCoord, y: yCoord)
    }
    
    func animateImageViews(){
        
        let topImageViewIndex = imagesList.count - 1
        
        ////point for moving the image dring animation
        let displacrImageViewToPoint = moveTo(imageView: imagesList[ (topImageViewIndex - 1) ], pathLength: moveToDistance)

        UIView.animate(
            withDuration: duration, 
            delay: 0.1, 
            options: [.curveEaseInOut], 
            animations: { [weak self] () -> Void in
                guard let this = self else { return }
                
                //make current displayed image thats at the top or last in array disappear
                this.imagesList[ topImageViewIndex ].alpha = 0 ////1
                
                //make next displayed image that is second to top or second to last in array appear
                this.imagesList[ (topImageViewIndex - 1) ].alpha = 1 /////0
                this.imagesList[ (topImageViewIndex - 1) ].transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                
                //moving the image while animating
                this.imagesList[ (topImageViewIndex - 1) ].center = displacrImageViewToPoint
                
            }, completion: { [weak self] _ in
                guard 
                    let this = self,
                    let lastImage = this.imagesList.last,
                    let index = this.imagesList.index(of: lastImage)
                    else { return }
                
                //remove disappearing image because it fully disappeared
                let lastImageTag = lastImage.tag
                this.removeImage(with: lastImageTag, index: index)
                
                //prepare and add new image in front of array that will be displayed next
                this.addImage(with: this.imageTag, alpha: 0.0, inFront: true) 
                
                //start process again 
                this.animateImageViews()
        })
        
        
    }
    
    
}
