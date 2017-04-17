//
//  MediaLayers.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 16/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import UIKit

class MediaLayers: NSObject {

    
    static var layers : [String] = ["Movie", "Video Game", "TV Series", "Music", "Book"]
    
    static var mediaTypes : [MediaType] = {
        return MediaType.AllMedias() 
    }()
    
    static var getProducts = [Product]()
    
    static func chosingMedia (mediaChosen: String) -> ProductLine? {
        
        switch mediaChosen {
        case "Movies":
            return ProductLine.films()
        case "Tv Series":
            return ProductLine.tvSeries()
        case "Video Games":
            return ProductLine.videoGames()
        case "Music":
            return ProductLine.music()
        case "Books":
            return ProductLine.books()
        default:
            return nil
        }
        
    }
    
}
