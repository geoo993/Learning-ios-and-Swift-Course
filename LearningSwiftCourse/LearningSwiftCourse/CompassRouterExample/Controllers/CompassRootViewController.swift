//
//  RootViewController.swift
//  UsingCompass
//
//  Created by GEORGE QUENTIN on 04/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import Compass

public class CompassRootViewController: CompassBaseViewController {

    //Mark: - Dismiss controller
    @IBAction func dismissbutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var titleLabel : UILabel!
    
    @IBAction func profile( _ sender : UIButton){
        //self.navigatorProfile()
        
        let url = URL(string: "compass://profile:George_Profile")!
        self.handleRoute(url, router: router)
    }
    
    @IBAction func book( _ sender : UIButton){
        //self.navigatorBook()
        
        let url = URL(string: "compass://book:pages:PetterRabbit:24")!
        self.handleRoute(url, router: router)
    }
    
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(title: nil)
    }
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        updateLabel(with: title)
    }
    
    // if this view controller is loaded from a storyboard, imageURL will be nil
  
    // Xcode 7 & 8
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .yellow
        updateLabel(with: self.title)
    }
    
    func updateLabel(with title: String?){
        titleLabel?.text = title
    }
    
}

