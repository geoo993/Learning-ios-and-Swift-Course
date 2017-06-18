//
//  InspirationalFilmsInfo.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

class InspirationalFilmsInfo {
    
    var year : Int
    var rating : Rating
    var genres : [Genres]
    
    init() {
        self.year = 2017
        self.rating = Rating.Unrated
        self.genres = [Genres.None]
    }
    
    init(year : Int, rating : Rating, genres : [Genres])
    {
        self.year = year
        self.rating = rating
        self.genres = genres
    }
    
    
}



