//
//  AirbnbData.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 07/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class AirbnbData {
    
    class Entry {
        
        var title: String
        var description : String
        var featuredImage : String
        
        init(title: String, description : String, featuredImage : String)
        {
            self.title = title
            self.description = description
            self.featuredImage = featuredImage
        }
    }
    
    let places = [
        Entry(title: "San Francisco", description: "San Francisco Golden Gate Bridge", featuredImage: "GoldenGateBridge"),
        Entry(title: "Snow Mountain", description: "Popular Destination", featuredImage: "naturemountain"),
        Entry(title: "Village", description: "Family Destination", featuredImage: "snowvillage"),
        Entry(title: "Bahamas", description: "North Beach Sunset", featuredImage: "NorthBeachSunset")
    ]

}

