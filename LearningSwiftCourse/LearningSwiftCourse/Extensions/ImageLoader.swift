//
//  ImageLoader.swift
//  AppCore
//
//  Created by GEORGE QUENTIN on 03/01/2019.
//  Copyright © 2019 Geo Games. All rights reserved.
//

public class ImageLoader {
    
    private let cache = NSCache<NSString, NSData>()
    
    func image(for url: URL, completion: @escaping(_ image: UIImage?) -> Void) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completion(UIImage(data: data as Data)) }
                return
            }
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completion(UIImage(data: data as Data)) }
        }
    }
}
