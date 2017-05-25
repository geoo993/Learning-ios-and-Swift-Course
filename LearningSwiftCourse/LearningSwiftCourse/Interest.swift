//
//  Interest.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class Interest {
    
    var title: String
    var description : String
    var numberOfMembers : Int
    var numberOfPosts : Int
    var featuredImage : UIImage!
    
    init(title: String, description : String, featuredImage : UIImage!)
    {
        self.title = title
        self.description = description
        self.numberOfMembers = 1
        self.numberOfPosts = 1
        self.featuredImage = featuredImage
        
    }
    
    static func createInterest() -> [Interest]
    {
        return [ 
            Interest(title: "We Love Traveling Around the World", description: "We Love backpack and adventures! We walked to Artartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea.", featuredImage: UIImage(named: "SnowyCartoonCave")),
            Interest(title: "Romance Stories", description: "We Love romantic stories, We Spend all our day taking care of every precious little things we still have available in this extraordary world. We just want to keep empowering people to continue to love one another.", featuredImage: UIImage(named: "pexels")),
            Interest(title: "We Love Games", description: "We Love playing and jaming together in our games room! Playing board games, drinking, laughing, going against each other and enjoying some the most amazing games of our current generation.", featuredImage: UIImage(named: "autumnlandscape")),
            Interest(title: "We Love Racing", description: "Cars and aircrafts and boats are our favourite racing vehicles. We love going to the mountains racing down the curvy slides and dangling along the coastline with our racers. Totally Amazing!", featuredImage: UIImage(named: "desert")),
            Interest(title: "I Love Words", description: "I wrote a book once about my lover and the child we had. It was the greatest book I've ever written and it turned out to be the greatest fictional story ever written. Even though the words in that book explained the tradegy that happened throughout my short loving time with my wife.", featuredImage: UIImage(named: "treesfallredleaves"))
        
        ]
    }
    
}
