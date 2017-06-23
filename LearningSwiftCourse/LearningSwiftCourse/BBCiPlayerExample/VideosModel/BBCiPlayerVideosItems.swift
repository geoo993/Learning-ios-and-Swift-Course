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
        
        static let allChannels = [BBCOne, BBCTwo, BBCThree,BBCFour,BBCRadio1, CBBC, CBeeBies,BBCNews,BBCParliament,BBCAlba,S4C]
        
        static let channelsImages : [UIImage] = [#imageLiteral(resourceName: "bbc_one"),#imageLiteral(resourceName: "bbc_two"),#imageLiteral(resourceName: "bbc_three"),#imageLiteral(resourceName: "bbc_four"),#imageLiteral(resourceName: "bbc_radio_1"),#imageLiteral(resourceName: "bbc_cbbc"),#imageLiteral(resourceName: "bbc_cbeebies"),#imageLiteral(resourceName: "bbc_news"),#imageLiteral(resourceName: "BBC_Parliament"),#imageLiteral(resourceName: "BBC_Alba"),#imageLiteral(resourceName: "bbc_s4c")]
    }
    
    enum ImageHeading : String {
        case Recommended = "RECOMMENDED"
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
