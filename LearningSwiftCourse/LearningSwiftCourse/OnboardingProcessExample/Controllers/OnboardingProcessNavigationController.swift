//
//  NavigationController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 16/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift

class OnboardingProcessNavigationController: UINavigationController {

    var coordinator : AppCoordinator!
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white 
        coordinator = AppCoordinator(services: AppServices(), navigator: self)
        
        coordinator.start()
        .subscribe(onNext: { _ in
        })
        .disposed(by: bag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
