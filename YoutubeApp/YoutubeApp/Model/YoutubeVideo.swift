//
//  YoutubeVideo.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 14/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit


class Channel : NSObject {
    let name : String
    let profileImageName : String
    init(name: String, profileImageName: String) {
        self.name = name
        self.profileImageName = profileImageName
    }
}

class YoutubeVideo : NSObject{
    let title : String
    let numberOfViews : Int
    let thumbnailImageName : String
    let uploadDate : String
    let duration : Int
    let channel : Channel
    
    init(title: String, numberOfViews : Int, thumbnailImageName: String, uploadDate : String, duration: Int) {
        self.title = title
        self.thumbnailImageName = thumbnailImageName
        self.numberOfViews = numberOfViews
        self.uploadDate = uploadDate
        self.duration = duration
        self.channel = Channel(name: "", profileImageName: "")
    }
    
    init(title: String, numberOfViews : Int, thumbnailImageName: String, uploadDate : String, duration: Int, channel: Channel) {
        self.title = title
        self.thumbnailImageName = thumbnailImageName
        self.numberOfViews = numberOfViews
        self.uploadDate = uploadDate
        self.duration = duration
        self.channel = channel
    }
}
