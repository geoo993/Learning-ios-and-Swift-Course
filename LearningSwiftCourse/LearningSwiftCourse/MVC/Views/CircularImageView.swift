//
//  CircularImageView.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

//https://stackoverflow.com/questions/29046571/cut-a-uiimage-into-a-circle-swiftios
//https://stackoverflow.com/questions/34984966/rounding-uiimage-and-adding-a-border

import UIKit

extension UIImage {
    
    func circularImage(with size: CGSize?) -> UIImage {
        let newSize = size ?? self.size
        
        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)
        
        
        context!.setBlendMode(.copy)
        context!.setFillColor(UIColor.clear.cgColor)
        
        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result!
    }
    
}

@IBDesignable
class CircularImageView: LayoutableImageView {

    
    override var image: UIImage? {
        didSet {
            super.image = image?.circularImage(with: nil)
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupViews() {
        super.setupViews()
    }
 
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    
    }

}
