//
//  LogoutViewController.swift
//  UsingCompass
//
//  Created by GEORGE QUENTIN on 04/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

public class CompassLogoutViewController: CompassBaseViewController {

    @IBAction func login( _ sender : UIButton){
        //self.navigatorLogin()
        
        let url = URL(string: "compass://login:George_logged_in")!
        self.handleRoute(url, router: router)
    }
    
    @IBAction func confirm( _ sender : UIButton){
        //self.navigatorConfirm()
        
        let url = URL(string: "compass://login//confirm")!
        self.handleRoute(url, router: router)
    }
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(title: nil)
    }
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
  
    // if this view controller is loaded from a storyboard, imageURL will be nil
    
    // Xcode 7 & 8
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .green
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
