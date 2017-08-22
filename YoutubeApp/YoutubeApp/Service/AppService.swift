//
//  AppService.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class AppService: NSObject {

    static let sharedInstance = AppService()
    
    func fetchVideos(completion : @escaping ([YoutubeVideo]) -> () ){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let er = error {
                print(er)
                return
            }
            
            if let dt = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: dt, options: .mutableContainers)
                    //print(json)
                    let jsonDictionary = json as! [[String:Any]]
                    
                    var videos = [YoutubeVideo]()
                    
                    for dictionary in jsonDictionary {
                        
                        if 
                            let title = dictionary["title"] as? String,
                            let numberOfViews = dictionary["number_of_views"] as? Int,
                            let thumbnailImageName = dictionary["thumbnail_image_name"] as? String,
                            let duration = dictionary["duration"] as? Int,
                            let channelFromJson = dictionary["channel"] as? [String : Any], 
                            let chanelName = channelFromJson["name"] as? String,
                            let chanelProfileImage = channelFromJson["profile_image_name"] as? String
                        {
                            let channel = Channel(name:chanelName, profileImageName: chanelProfileImage)
                            let video = YoutubeVideo(title: title, numberOfViews: numberOfViews, thumbnailImageName: thumbnailImageName, uploadDate: "today", duration: duration, channel: channel)
                            
                            videos.append(video)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                //let str = NSString(data: dt, encoding: String.Encoding.utf8.rawValue)
                //print(str)
            }
            
            }.resume()
    }
}
