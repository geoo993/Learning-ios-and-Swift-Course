//
//  OnboardingCoordinator.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OnboardingCoordinator {
    let storyboard = UIStoryboard(name: "OnboardingProcessMain", bundle: Bundle(identifier: Bundle.main.bundleIdentifier!))
    
    let navigator : UINavigationController
    let services : Services
    
    init(navigator: UINavigationController, services: Services) {
        self.navigator = navigator
        self.services = services
    }
    
    func start() -> Observable<Void> {
        
        return Observable.just()
        .flatMap { _ -> Observable<Void> in 
            let vc = self.storyboard.instantiateViewController(withIdentifier: "OnboardingWalkthroughPageViewController") as! OnboardingWalkthroughPageViewController
            vc.title = "Tutorial"
            vc.walkthroughModelService = self.services.walkthroughPageModelServices
            self.navigator.pushViewController(vc, animated: false)
            return Observable.merge(vc.didCompleteWalkthrough, vc.didPressSkip)
        }
        .flatMap({ _ -> Observable<[String]> in 
            
            self.navigator.isNavigationBarHidden = true
            
            let bookSelectionVC = self.storyboard.instantiateViewController(withIdentifier: "OnboardingBookSelectionViewController") as! OnboardingBookSelectionViewController
            bookSelectionVC.title = "Select Books"
            
            self.navigator.pushViewController(bookSelectionVC, animated: false)
        
            return bookSelectionVC.didCompleteBooksSelection
        })
        .flatMap({ booksSelected -> Observable<String> in
            self.navigator.isNavigationBarHidden = false
            
            let myReadingVC = self.storyboard.instantiateViewController(withIdentifier: "MyReadingViewController") as! MyReadingViewController
            self.navigator.pushViewController(myReadingVC, animated: false)
            
            myReadingVC.selectedBooks = booksSelected
            myReadingVC.title = "My Reading"
            myReadingVC.navBarHeight = (self.navigator.isNavigationBarHidden) ? 0 : self.navigator.navigationBar.frame.height
            myReadingVC.disableNavBackButton()
            myReadingVC.addMenuButton(with: self, selector:#selector(self.menuTapped))
            
            return myReadingVC.didCompleteBookSelection
        })
        .flatMap({ bookSelected -> Observable<Void> in 
            self.navigator.isNavigationBarHidden = false
            
            let bookVC = self.storyboard.instantiateViewController(withIdentifier: "MyBookViewController") as! MyBookViewController
            self.navigator.pushViewController(bookVC, animated: false)
            bookVC.currentBook = bookSelected
            bookVC.title = bookSelected
            bookVC.disableNavBackButton()
            bookVC.addMenuButton(with: self, selector:#selector(self.menuTapped))
            
            return bookVC.didCompleteBook
        })
        
    }
    
    @objc func menuTapped(){
        print("tapped")
    }
    
}

//                return Observable<Void>.create { observer in 
//                    
//                    return permissionVC.didAllowPermissions
//                        .do(onNext: {
//                            self.navigator.topViewController?.dismiss(animated: true, completion: { success in
//                                observer.onNext()
//                            })
//                        })
//                        .ignoreElements()
//                        .subscribe(observer)
