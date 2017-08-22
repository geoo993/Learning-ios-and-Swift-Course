//
//  MockServices.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation

class MockServices : Services {
    let walkthroughPageModelServices: WalkthroughModelService
    let bookShelfService: BookShelfService

    init() {
        self.walkthroughPageModelServices = WalkthroughModelMockService()
        self.bookShelfService = BookshelfMockService()
    }
}

class BookshelfMockService : BookShelfService {
    func getBooks() -> [BookModel] {
        return []
    }
}
