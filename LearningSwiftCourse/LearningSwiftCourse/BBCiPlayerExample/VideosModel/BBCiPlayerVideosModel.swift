//
//  BBCiPlayerVideosModel.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

struct BBCiPlayerVideosModel {  
    enum Continent {
        case World
        case Americas
        case Europe
        case MiddleEast
        case Africa
        case AsiaPacific
        case Australia
        
        func toString() -> String {
            switch self {
            case .World:
                return "World"
            case .Americas:
                return "Americas"
            case .Europe:
                return "Europe"
            case .MiddleEast:
                return "Middle East"
            case .Africa:
                return "Africa"
            case .AsiaPacific:
                return "Asia-Pacific"
            case .Australia:
                return "Australia"
            }
        }
        
        func toColor() -> UIColor {
            switch self {
            case .World:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1.0)
            case .Americas:
                return UIColor(red: 114, green: 0.639, blue: 984, alpha: 1.0)
            case .Europe:
                return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1.0)
            case .MiddleEast:
                return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1.0)
            case .Africa:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1.0)
            case .AsiaPacific:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1.0)
            case .Australia:
                return UIColor(red: 0.720, green: 0.176, blue: 0.453, alpha: 1.0)
            }
        }
        
    }
    
    let continent: Continent
    let country: String
    let summary: String
}
