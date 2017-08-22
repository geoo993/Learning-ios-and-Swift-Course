//
//  Extensions.swift
//  youtube
//
//  Created by Brian Voong on 6/3/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIView {
    func addConstraints(with format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func addCenterConstraints(with view: UIView) {
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}


public extension UIColor {
    
    static var random: UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }   
    
    static func topMenuRedColor() -> UIColor {
        return UIColor.rgb(red: 230, green: 32, blue: 31)
    }   
    
    static func nonSelectedColor() -> UIColor {
        return UIColor.rgb(red: 91, green: 14, blue: 13)
    }   
}

extension UIViewController {
    var appDelegate:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}

struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "," // or possibly "." / "," / " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
extension Int {
    var stringWithSepator: String {
        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
    }
}

//image cache
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(with urlString: String ) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        let objectIncache = urlString as AnyObject
        if let imageFromCache = imageCache.object(forKey: objectIncache) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let er = error {
                print(er)
                return 
            }
            DispatchQueue.main.async {
                if let dt = data, let imageToCache = UIImage(data: dt ) {
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: objectIncache)
                }
            }
        }).resume() 
    }
    
}


