//
//  MediaType.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 13/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

class MediaType {
    
    var title: String
    var description : String
    var image : UIImage
   
    init(title: String, description : String, imageName: String)
    {
        self.title = title
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        }else {
            image = UIImage(named: "noImage") ?? UIImage() 
        }
        
    }
    
    class func AllMedias() -> [MediaType]{
        
        let filmMedia = MediaType(title: "Movies", description: "", imageName: "film")
        
        let booksMedia = MediaType(title: "Books", description: "", imageName: "books")
        
        let tvSeriesMedia = MediaType(title: "Tv Series", description: "", imageName: "tvSeries")
        
        let videoGamesMedia = MediaType(title: "Video Games", description: "", imageName: "videoGame")
        
        let musicMedia = MediaType(title: "Music", description: "", imageName: "music")
        
        return [filmMedia, videoGamesMedia, tvSeriesMedia, musicMedia, booksMedia]
        
    }
    
}

