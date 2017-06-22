//
//  UIView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
// from : https://stackoverflow.com/questions/30953201/adding-blur-effect-to-background-in-swift

import Foundation
import UIKit


public extension UIView {
    
    public func snapShotImage(withSize size: CGSize, opaque: Bool = false, offset :CGPoint = CGPoint.zero) -> UIImage {
        
        ///size, opaque, scale
        //UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)){
            UIGraphicsBeginImageContextWithOptions(size, opaque, UIScreen.main.scale);
        }
        else
        {
            UIGraphicsBeginImageContext(size);
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.translateBy(x: -offset.x, y: -offset.y)
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    ///takes anyview and creates an image from it using its frame
    public func bluredImage(radius:CGFloat = 1) -> UIImage {
        
        if self.superview == nil
        {
            return UIImage()
        }
        
        let image = self.snapShotImage(withSize: self.frame.size)
        
        guard let source = image.cgImage else { return UIImage() }
        
        let context = CIContext(options: nil)
        let inputImage = CIImage(cgImage: source)
        
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(inputImage, forKey: kCIInputImageKey)
        
        if let clampedImage = clampFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let explosureFilter = CIFilter(name: "CIExposureAdjust")
            explosureFilter?.setValue(clampedImage, forKey: kCIInputImageKey)
            explosureFilter?.setValue(-1.0, forKey: kCIInputEVKey)
            
            if let explosureImage = explosureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(explosureImage, forKey: kCIInputImageKey)
                filter?.setValue("\(radius)", forKey:kCIInputRadiusKey)
                
                if let resultImage = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                    let imageWidth = inputImage.extent.size.width
                    let imageHeight = inputImage.extent.size.height 
                    let boundingRect = CGRect(x:0, y:0, width:imageWidth, height: imageHeight)
                    guard let cgImage = context.createCGImage(resultImage, from: boundingRect) else { return UIImage() }
                    let filteredImage = UIImage(cgImage: cgImage)
                    return filteredImage
                }
            }
            
        }
        
        return UIImage()
    }
    
    public func applyBlurWithCrop(radius:CGFloat = 1, cropBy:CGFloat = 1) -> UIImage {
        
        if self.superview == nil
        {
            return UIImage()
        }
        
        let image = self.snapShotImage(withSize: self.frame.size)
        
        /// convert UIImage to CIImage
        let inputImage = CIImage(image: image)
        
        // Create Blur CIFilter, and set the input image
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter?.setValue(inputImage, forKey: kCIInputImageKey)
        blurfilter?.setValue(radius, forKey: kCIInputRadiusKey)
        
         // Get the filtered output image and return it
        if let resultImage = blurfilter?.value(forKey: kCIOutputImageKey) as? CIImage, 
            let imageWidth = inputImage?.extent.size.width ,
            let imageHeight = inputImage?.extent.size.height {
            var blurredImage = UIImage(ciImage: resultImage)
            
            let half = CGFloat(2)
            let xPos = -(cropBy/half)
            let yPos = -(cropBy/half)
            let boundingRect = CGRect(x: xPos, y:yPos, width:imageWidth + cropBy, height: imageHeight + cropBy)
            let cropped:CIImage = resultImage.cropping(to: boundingRect)
            blurredImage = UIImage(ciImage: cropped)
            return blurredImage
            
        }else { return UIImage() }
    }
    
    
    public func blurNewView(newChild: UIView, effect: UIBlurEffectStyle){
        let parent = self
        
        // Blur Effect
        let blurEffect = UIBlurEffect(style: effect)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = parent.bounds
        parent.addSubview(blurEffectView)
        
        // Vibrancy Effect
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = parent.bounds
        
        // Add label to the vibrancy view
        vibrancyEffectView.contentView.addSubview(newChild)
        
        // Add the vibrancy view to the blur view
        blurEffectView.contentView.addSubview(vibrancyEffectView)
    }
    
    func addBlurEffectToTopView() {
        // Add blur view
        let view = self
        
        //This will let visualEffectView to work perfectly
        if let navBar = view as? UINavigationBar{
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
        }
        
        var bounds = view.bounds
        bounds.offsetBy(dx: 0.0, dy: -20.0)
        bounds.size.height = bounds.height + 20.0
        
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(visualEffectView, at: 0)
        
    }
    
    
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    public func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    public func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    // Recursive remove subviews and constraints
    public func removeSubviews() {
        self.subviews.forEach({
            if !($0 is UILayoutSupport) {
                $0.removeSubviews()
                $0.removeFromSuperview()
            }
        })
        
    }
    
    // Recursive remove subviews and constraints
    public func removeSubviewsAndConstraints() {
        self.subviews.forEach({
            $0.removeSubviewsAndConstraints()
            $0.removeConstraints($0.constraints)
            $0.removeFromSuperview()
        })
    }
    
    public func removeEverything (){
        while(self.subviews.count > 0) 
        {
            self.removeSubviewsAndConstraints()
        }
    }
    
}
