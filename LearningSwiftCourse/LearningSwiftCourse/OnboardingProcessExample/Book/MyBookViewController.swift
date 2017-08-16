//
//  BookViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MyBookViewController : UIViewController {
    
    let didCompleteBook = PublishSubject<Void>()
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var bookLabel : UILabel!
    
    var currentBook : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = currentBook {
            bookLabel.text = book
        }
    }
    
    
}
