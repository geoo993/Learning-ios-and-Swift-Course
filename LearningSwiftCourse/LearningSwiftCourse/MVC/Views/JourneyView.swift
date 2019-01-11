//
//  ProgressView.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//
// https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios8-swift
// https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios10

import LearningSwiftCourseExtensions
import UIKit

public class JourneyView: UIControl {

    var imageView = UIImageView()
    var title : String = ""
    var originalColor : UIColor = UIColor.white
    var originalPoint : CGPoint = CGPoint.zero
    var image : UIImage?
    
    fileprivate let lockedImage : UIImage? = #imageLiteral(resourceName: "lock-icon")
    fileprivate let lockedImageSize = CGSize(width: 30, height: 30)
    fileprivate let minAlpha : CGFloat = 0.5
    
    fileprivate var widthConstraint = NSLayoutConstraint()
    fileprivate var heightConstraint = NSLayoutConstraint()
    fileprivate var horizontalConstraint = NSLayoutConstraint()
    fileprivate var verticalConstraint = NSLayoutConstraint()
    
    public var imageSize : CGSize = CGSize.zero {
        didSet{
            widthConstraint.constant = imageSize.width
            heightConstraint.constant = imageSize.height
        }
    }
    
    public var isSelect: Bool = false {
        didSet{
            if isLocked == false {
                if (isSelect){
                    dimButton()
                }else{
                    showButton()
                }
            }
        }
    }
    
    public var isHeld: Bool = false{
        didSet{
            if isLocked == false {
                if (isHeld){
                    dimButton()
                }else{
                    showButton()
                }
            }
        }
    }
    
    public var isLocked: Bool = false {
        didSet{
            self.backgroundColor = isLocked ? UIColor.lightGray : originalColor
            
            if (isLocked){
                if let img = lockedImage {
                    imageView.frame = CGRect(origin: CGPoint.zero, size: lockedImageSize)
                    imageView.image = img.imageWithSize(size: lockedImageSize, extraMargin: 0)
                }
            }else {
                imageView.image = image?.imageWithSize(size: lockedImageSize, extraMargin: 0)
            }
        }
    }
    
    private func dimButton (){
        self.alpha = minAlpha
    }
    
    private func showButton (){
        dimButton()
        UIView.animate(withDuration: 0.3) { [weak self] () in
            self?.alpha = 1.0
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup(){
        self.removeEverything()
        
        // setup image view
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
        widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageSize.width)
        //imageView.addConstraint(widthConstraint)
        
        heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageSize.height)
        //imageView.addConstraint(heightConstraint)
        
        horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        
        verticalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        self.addConstraint(verticalConstraint)
        
        // set values when the button is loaded or created
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width * 0.5
    }
    
    func setupTouchGestures( target: Any?, touchDown : Selector,touchUpInside : Selector){
        // target touches
        self.addTarget(target, action: touchDown, for: .touchDown)
        self.addTarget(target, action: touchUpInside, for: .touchUpInside)
    }
    
    func setupTapGesture( target: Any?, tapSelector : Selector){
        
        // Tap gesture
        let tapRecognizer = UITapGestureRecognizer(target: target, action: tapSelector)
        tapRecognizer.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func setupPanGesture( target: Any?, panSelector : Selector){
        
        // Pan gesture
        let panRecognizer = UIPanGestureRecognizer(target: target, action: panSelector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panRecognizer)
    }
    
   
    /*
    @objc func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translation(in: self.superview!)
        self.center = CGPoint(x:center.x + translation.x, y:center.y + translation.y)
        panGestureRecognizer.setTranslation(CGPoint.zero, in: self.superview!)
     
        /*
        switch panGestureRecognizer.state {
        case .began:
            break
        case .changed:
            break
        case .ended:
            break
        default:
            break
        }
        */
    
    }
    */
    
    
}
