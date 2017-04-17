//
//  Product.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 12/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

public enum ProductRating
{
    case Unrated
    case Average
    case Ok
    case Good
    case Excellent
    case Brilliant
    case Outstanding
}

public enum Genres
{
    case None
    case Biography
    case Crime
    case Adventure
    case Drama
    case Action
    case Horror
    case Comedy
    case Animation
    case Romance
    case Thriller
    case Family
    case Sport
    case Documentary
}

class Product {
    
    var title: String
    var description : String
    var image : UIImage
    var rating : ProductRating
    var year : Int
    var genres : [Genres]
    
    init(title: String, description : String, imageName: String, year: Int, rating: ProductRating , genres: [Genres])
    {
        self.title = title
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        }else {
            image = UIImage(named: "noImage") ?? UIImage() 
        }
        self.year = year
        self.rating = rating
        self.genres = genres
        
    }
    
    
}
