//
//  UIImageView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 18/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

//http://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
//http://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
//http://stackoverflow.com/questions/29472149/swift-how-to-display-an-image-using-url

public extension UIImageView {
    
    public func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    public func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    
    public func downloadImageFrom(url:URL){
        
        if let imageData = NSData(contentsOf: url)  {
            let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
            let data: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
            if let dataImage = UIImage(data: data as Data) {
                self.image = dataImage
            }else{
                self.image = UIImage(named: "noImage") ?? UIImage() 
                
            }
            
        }        
        
    }
    
    public func imageFromUrl(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
         
            guard let data = data, error == nil else { 
                self.image = UIImage(named: "noImage") ?? UIImage() 
                return 
            }
            
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }.resume()
        
    }
    
    public func loadFromURL(url: URL)  {
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if data != nil {
                    self.image = UIImage(data: data!)
                }else{
                    self.image = UIImage(named: "noImage") ?? UIImage() 
                    
                }
            }
        }
        
        
    }
      
    public func blurImage()
    {
        let _ = self.subviews.filter({ $0 is UIVisualEffectView }).map({ $0.removeFromSuperview() })
        
        var blurEffect:UIBlurEffect = UIBlurEffect()
        if #available(iOS 10.0, *) { //iOS 10.0 and above
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)//prominent,regular,extraLight, light, dark
        } else { //iOS 8.0 and above
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) //extraLight, light, dark
        }
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        //self.addSubview(blurEffectView)
        self.insertSubview(blurEffectView, at: 0) 
        
    }
    
    public func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
    
}

//image cache
let imageCache = NSCache<AnyObject, AnyObject>()

public class CustomImageView : UIImageView {
    
    public var imageUrlString : String?
    
    public func loadImageUsingUrlString(with urlString: String ) {
        
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


