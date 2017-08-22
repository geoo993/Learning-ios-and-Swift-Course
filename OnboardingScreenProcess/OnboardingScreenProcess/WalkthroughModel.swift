//
//  WalkthroughModel.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 09/08/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

public struct WalkthroughModel {
    public let pages : [WalkthroughPageModel]
}

public struct WalkthroughPageModel {
    public let imageUrl : String
    public let title : String
    public let description : String
}


public class WalkthroughModelMockService : WalkthroughModelService {
    public init() {
        
    }
    
    public func getWalkthroughModel() -> WalkthroughModel {
        let page1 = WalkthroughPageModel(imageUrl: "http://www.smallbiztechnology.com/wp-content/uploads/2016/03/onboarding-300x187.jpg", title: "Read and get help learning words", description: "By placing your finger on each word as you are readng it we can tell you how well you are doing")
        let page2 = WalkthroughPageModel(imageUrl: "http://vnmanpower.com/images/blog/2015/10/26/original/everyone-loves-this-onboarding-process_1445848784.jpg", title: "Replay your reading and your friends", description: "You can replay your reading and listen to others and how they say the word")
        let page3 = WalkthroughPageModel(imageUrl: "http://www.smallbiztechnology.com/wp-content/uploads/2016/03/onboarding-300x187.jpg", title: "Lorem ipsum", description: "............................................. ............................................. ........................................how this benefits you")
        return WalkthroughModel(pages: [page1, page2, page3])
    }
}
