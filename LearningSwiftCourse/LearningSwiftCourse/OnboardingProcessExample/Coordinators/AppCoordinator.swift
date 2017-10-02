//
//  AppCoordinator.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AppCoordinator {
    
    var navigator = UINavigationController()
    let storyboard = UIStoryboard(name: "OnboardingProcessMain", bundle: Bundle(identifier: Bundle.main.bundleIdentifier!))
    
    let services : Services
    init(services: Services) {
        self.services = services
        setupNavigationBar()
    }
    init(services: Services, navigator: UINavigationController) {
        self.services = services
        self.navigator = navigator
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigator.isNavigationBarHidden = true
        navigator.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont.init(name:"HelveticaNeue-Bold", size: 20.0) ?? UIFont.boldSystemFont(ofSize:20.0)]
    }
    
    let bag = DisposeBag()
    
    func start() -> Observable<Void> {
        
        return Observable.just((Any).self)
        .flatMap({ _ -> Observable<String> in 
        
            let vc = self.storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigator.pushViewController(vc, animated: false)
            vc.title = "Login"
            
            return vc.didCompleteLogin
        })
        .flatMap({ masterUser -> Observable<Void> in 
            
            //how to pass the master user down
            
            let permissionVC = self.storyboard.instantiateViewController(withIdentifier: "MicrophonePermisionsViewController") as! MicrophonePermisionsViewController
            self.navigator.topViewController?.present(permissionVC, animated: true, completion: nil)
            permissionVC.title = "Allow Microphone"
            
            return permissionVC.didAllowPermissions
                .do(onNext: { _ in
                    self.navigator.topViewController?.dismiss(animated: true, completion: nil)
                })
        })
        .flatMap({ masterUser -> Observable<String> in 
            
            let vc = self.storyboard.instantiateViewController(withIdentifier: "SelectAccountViewController") as! SelectAccountViewController
            self.navigator.pushViewController(vc, animated: false)
            vc.title = "Select Account"
            
            vc.didSelectAddStudent
            .flatMap({ _ -> Observable<Void> in
                
                let addAccountVC = self.storyboard.instantiateViewController(withIdentifier: "AddAccountViewController") as! AddAccountViewController
                self.navigator.topViewController?.present(addAccountVC, animated: true, completion: nil)
                addAccountVC.title = "Add Account"
                
                return addAccountVC.didAddStudent
                    .do(onNext: { _ in
                        self.navigator.topViewController?.dismiss(animated: true, completion: nil)
                    })
            })
            .subscribe(onNext: { _ in
                print("A student has been added")
                
            }).addDisposableTo(self.bag)
            
            return vc.didSelectStudent
        })
        .flatMap({ studentName -> Observable<Void> in 
            
            let defaults = UserDefaults.standard
            let hasRunBefore = "Has run before"
            let studentHasRunBefore = hasRunBefore + " - " + studentName
            let firstRun = defaults.bool(forKey: studentHasRunBefore)
            if firstRun == false {
                defaults.set(true, forKey: hasRunBefore)
                let onboardingCoordinator = OnboardingCoordinator(navigator: self.navigator, services:self.services)
                
                return onboardingCoordinator.start()        
            } else {
                return Observable.empty()
            }
            
        })
        .flatMap({ _ -> Observable<Void> in 
            
            let vc = self.storyboard.instantiateViewController(withIdentifier: "MyBookViewController") as! MyBookViewController   
            self.navigator.pushViewController(vc, animated: true)
            
            return Observable.empty()
            
        })
        
    }
}
