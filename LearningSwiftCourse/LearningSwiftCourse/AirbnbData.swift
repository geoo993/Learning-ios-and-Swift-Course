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
        Entry(title: "Bridge", description: "", featuredImage: "GoldenGateBridge"),
        Entry(title: "Mountain", description: "", featuredImage: "naturemountain"),
        Entry(title: "Village", description: "", featuredImage: "snowvillage"),
        Entry(title: "North Beach", description: "", featuredImage: "NorthBeachSunset")
    ]

}

