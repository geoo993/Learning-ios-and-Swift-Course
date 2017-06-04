//
//  String+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    static func getItemUrlFromBundle (bundleID: String, itemName:String, extention: String, subDirectory:String = "") -> URL? {
        guard let bundle = Bundle(identifier: bundleID) else { 
            print("Bundle ID is not valid")
            return nil 
        }
        let url = bundle.url(forResource: itemName, withExtension: extention, subdirectory: subDirectory)
        return url
    }
    static func getItemPathFromBundle (bundleID: String, itemName:String, type: String, inDirectory:String = "") -> String? {
        guard let bundle = Bundle(identifier: bundleID) else { 
            print("Bundle ID is not valid")
            return nil 
        }
        let path = bundle.path(forResource: itemName, ofType: type, inDirectory: inDirectory)
        return path
    }
}
