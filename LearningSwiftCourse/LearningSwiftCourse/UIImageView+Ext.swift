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

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    
    func downloadImageFrom(url:URL){
        
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
    
    func loadFromURL(url: URL)  {
        
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
    
    
    /*
     // Creating a session object with the default configuration.
     // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
     let session = URLSession(configuration: .default)
     
     // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
     let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
     // The download has finished.
     if let e = error {
     print("Error downloading cat picture: \(e)")
     } else {
     // No errors found.
     // It would be weird if we didn't have a response, so check for that too.
     if let res = response as? HTTPURLResponse {
     print("Downloaded cat picture with response code \(res.statusCode)")
     if let imageData = data {
     // Finally convert that Data into an image and do what you wish with it.
     let image = UIImage(data: imageData)
     // Do something with your image.
     self.imageviewNewItemImage.image = image
     } else {
     print("Couldn't get image: Image is nil")
     }
     } else {
     print("Couldn't get response code for some reason")
     }
     }
     }
     downloadPicTask.resume()
     */
    
}
