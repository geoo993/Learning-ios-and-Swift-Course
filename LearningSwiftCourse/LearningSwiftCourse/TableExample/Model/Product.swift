//
//  Product.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 12/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

public enum Rating : String
{
    case Unrated = "Unrated"
    case Average = "Average" 
    case Ok = "Ok"
    case Good = "Good"
    case Excellent = "Excellent"
    case Brilliant = "Brilliant"
    case Outstanding = "Outstanding"
}

public enum Genres : String
{
    case None = "None"
    case Biography = "Biography"
    case Crime = "Crime"
    case Adventure = "Adventure"
    case Drama = "Drama"
    case Action = "Action"
    case Horror = "Horror"
    case History = "History"
    case Comedy = "Comedy"
    case Animation = "Animation"
    case Romance = "Romance"
    case Thriller = "Thriller"
    case Family = "Family"
    case Fantasy = "Fantasy"
    case Sport = "Sport"
    case SciFi = "SciFi"
    case Documentary = "Documentary"
    case Mystery = "Mystery"
    case War = "War"
}

class Product {
    
    var title: String
    var description : String
    var image : UIImage
    var rating : Rating
    var year : Int
    var genres : [Genres]
   
    init(title: String, description : String, imageName: String, year: Int, rating: Rating , genres: [Genres])
    {
        self.title = title
        self.description = description
        if let img = UIImage(named: imageName) {
            self.image = img
        }else {
            self.image = UIImage(named: "noImage") ?? UIImage() 
        }
        self.year = year
        self.rating = rating
        self.genres = genres
        
    }
    
    init(title: String, description : String, image: UIImage?, year: Int, rating: Rating , genres: [Genres])
    {
        self.title = title
        self.description = description
        if let img = image {
            self.image = img
        }else {
            self.image = UIImage(named: "noImage") ?? UIImage() 
        }
        self.year = year
        self.rating = rating
        self.genres = genres
        
    }
    
    
}


extension Product {
    
    var titleFirstLetter: String {
        return String(self.title[self.title.startIndex]).uppercased()
    }
    
}
