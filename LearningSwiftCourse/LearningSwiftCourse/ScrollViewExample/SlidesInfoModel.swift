//
//  SlidesInfoModel.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation


struct SlidesInfoModel {
    var title: String
    var description: String
    var imageName: String
}

//Load pList file and cast the data to SlideInfoModel
func LoadSlidesPropertyListFile ()-> [SlidesInfoModel]{
    guard let path = Bundle.main.path(forResource: "slides_info", ofType: "plist") else { 
        print("File does not exist")
        return []
    }
    
    let url = URL.init(fileURLWithPath: path)
    let arrayOfInfo = NSArray.init(contentsOf: url) as! [NSDictionary]
    
    return arrayOfInfo.flatMap{ dic -> SlidesInfoModel in
        let title = dic["title"] as! String
        let description = dic["description"] as! String
        let imageName = dic["imageName"] as! String
        
        return SlidesInfoModel(title: title, description: description, imageName: imageName)
    }
}
