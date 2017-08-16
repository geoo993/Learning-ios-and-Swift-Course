//
//  AppServices.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation

class AppServices : Services {
    let walkthroughPageModelServices: WalkthroughModelService
    let bookShelfService: BookShelfService
    init() {
        self.walkthroughPageModelServices = WalkthroughModelMockService()
        self.bookShelfService = BookshelfMockService()
    }
}
