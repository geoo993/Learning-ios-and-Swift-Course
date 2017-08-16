//
//  ViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift


class MicrophonePermisionsViewController: UIViewController {

    let didAllowPermissions = PublishSubject<Void>()
    
    @IBOutlet weak var allowMicPermissionButton : UIButton!
    
    @IBAction func didTapAllowMicPermissionButton(_ sender: UIButton) {
        didAllowPermissions.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

