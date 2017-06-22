//
//  BBCiPlayerVideosItems.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

struct BBCiPlayerVideosItems {  
    
    enum Channels : String {
        case BBCOne = "BBC One"
        case BBCTwo = "BBC Two"
        case BBCThree = "BBC Three"
        case BBCFour = "BBC Four"
        case BBCRadio1 = "BBC Radio 1"
        case CBBC = "CBBC"
        case CBeeBies = "CBeeBies"
        case BBCNews = "BBC News"
        case BBCParliament = "BBC Parliament"
        case BBCAlba = "BBC Alba"
        case S4C = "S4C"
        case Recommended = "RECOMMENDED"
        
        static let allChannels = [BBCOne, BBCTwo, BBCThree,BBCFour,BBCRadio1, CBBC, CBeeBies,BBCParliament,BBCAlba,S4C]
    }
    
    enum ImageHeading : String {
        case NewSeries = "NEW SERIES"
        case FullSeries = "FULL SERIES"
        case LastChance = "LAST CHANCE"
        case Exclusive = "EXCLUSIVE"
        case None = ""
        static let allImageHeadings = [NewSeries, FullSeries, LastChance, None]
    }
    
    let channel: Channels
    let imageHeading : ImageHeading
    let videoTitle: String
    let summary: String
}
