//
//  Services.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation

protocol Services {
    var walkthroughPageModelServices : WalkthroughModelService { get }
    var bookShelfService : BookShelfService { get }
}

protocol WalkthroughModelService {
    func getWalkthroughModel() -> WalkthroughModel
}

protocol BookShelfService {
    func getBooks() -> [BookModel]
}
