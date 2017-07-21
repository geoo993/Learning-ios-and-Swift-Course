//
//  UIView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
// from : https://stackoverflow.com/questions/30953201/adding-blur-effect-to-background-in-swift
//https://stackoverflow.com/questions/9115854/uiview-hide-show-with-animation
//https://stackoverflow.com/questions/6177393/how-to-add-animation-while-changing-the-hidden-mode-of-a-uiview

import Foundation
import UIKit

private let UIViewVisibilityShowAnimationKey = "UIViewVisibilityShowAnimationKey"
private let UIViewVisibilityHideAnimationKey = "UIViewVisibilityHideAnimationKey"

private class UIViewAnimationDelegate: NSObject, CAAnimationDelegate {
    weak var view: UIView?
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard let view = self.view, flag else {
            return
        }
        view.isHidden = !view.visible
        view.removeVisibilityAnimations()
    }
}

public extension UIView {
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }

    public static func createPickerViewItem(with frame : CGRect, text: String) -> UIView {
        
        let view = UIView(frame: frame )
        
        let label = UILabel(frame: view.frame)
        label.text = text
        label.textAlignment = .center
        label.contentMode = .center
        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)
        
        return view
    }
    
    
    public func shakeView(repeatCount: Float){
        
        let view = self
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            //view.isHidden = true
        })
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = repeatCount
        shake.autoreverses = true
        
        let from_point = CGPoint(x: view.center.x - 5, y: view.center.y)
        let from_value : NSValue = NSValue(cgPoint: from_point)
        
        let to_point = CGPoint(x: view.center.x + 5, y:view.center.y)
        let to_value : NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        view.layer.add(shake, forKey: "position")
        
        //shake.delegate = self
        
        CATransaction.commit()
    }
    
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
        mask.frame = self.layer.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        //https://stackoverflow.com/questions/10167266/how-to-set-cornerradius-for-only-top-left-and-top-right-corner-of-a-uiview
        
    }
    
    
    public func addBorder(with color: UIColor = .black, width: CGFloat = 1.0, radius : CGFloat = 10.0){
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    public func addShadow(with width:CGFloat = 0.2, height:CGFloat = 0.2, opacity:Float = 0.7, maskToBounds:Bool=false, radius:CGFloat = 0.5){
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = maskToBounds
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
    
    
    ///tempView = UIView()
    ///originalView.copyViewElements(to: tempView)
    func copyViewElements(to view : UIView){
        for subView in self.subviews{
            let subViewCopy = UIView()
            subView.copyViewElements(to: subViewCopy)
            view.addSubview(subViewCopy.copyView())
            view.addConstraints(subViewCopy.constraints)
        }
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

    /**
     Removes all constrains for this view
     */
    func removeConstraints() {
        
        let constraints = self.superview?.constraints.filter{
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
            } ?? []
        
        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
    
    func removeSubview<T>(with type : T.Type){
        for subview in self.subviews {
            if (subview is T) {
                subview.removeEverything()
                subview.removeFromSuperview()
            }
        }
    }
    
    func removeSubview(with view : UIView){
        for subview in self.subviews {
            if (subview == view) {
                subview.removeEverything()
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func removeVisibilityAnimations() {
        self.layer.removeAnimation(forKey: UIViewVisibilityShowAnimationKey)
        self.layer.removeAnimation(forKey: UIViewVisibilityHideAnimationKey)
    }
    
    var visible: Bool {
        get {
            return !self.isHidden && self.layer.animation(forKey: UIViewVisibilityHideAnimationKey) == nil
        }
        
        set {
            let visible = newValue
            
            guard self.visible != visible else {
                return
            }
            
            let animated = UIView.areAnimationsEnabled
            
            self.removeVisibilityAnimations()
            
            guard animated else {
                self.isHidden = !visible
                return
            }
            
            self.isHidden = false
            
            let delegate = UIViewAnimationDelegate()
            delegate.view = self
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = visible ? 0.0 : 1.0
            animation.toValue = visible ? 1.0 : 0.0
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.delegate = delegate
            
            self.layer.add(animation, forKey: visible ? UIViewVisibilityShowAnimationKey : UIViewVisibilityHideAnimationKey)
        }
    }
    
    func setVisible(visible: Bool, animated: Bool) {
        let wereAnimationsEnabled = UIView.areAnimationsEnabled
        
        if wereAnimationsEnabled != animated {
            UIView.setAnimationsEnabled(animated)
            defer { UIView.setAnimationsEnabled(!animated) }
        }
        
        self.visible = visible
    }
    
    
    func setHidden(with hidden: Bool, animated:Bool)
    {
        // If the hidden value is already set, do nothing
        if (hidden == self.isHidden) {
            return
        }
        // If no animation requested, do the normal setHidden method
        else if (animated == false) {
            self.isHidden = hidden // self.setHidden(with: hidden)
            return
        }
        else {
            // Store the view's current alpha value
            let originalAlpha = self.alpha
        
            // If we're unhiding the view, make it invisible initially
            if (hidden == false) {
                self.alpha = 0
            }
    
            // Unhide the view so we can see the animation
            self.isHidden = false
    
            // Do the animation
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { [weak self] () -> Void in
                            // Start animation block
                            if (hidden == true) {
                                self?.alpha = 0
                            }else {
                                self?.alpha = originalAlpha;
                            }
                            self?.layoutIfNeeded()
                            // End animation block
            }, completion: { [weak self] (completed) -> Void in
                // Start completion block
                // Finish up by hiding the view if necessary...
                self?.isHidden = hidden
                // ... and putting back the correct alpha value
                self?.alpha = originalAlpha;
                // End completion block
            })
        }
        
    }
    
    
}
