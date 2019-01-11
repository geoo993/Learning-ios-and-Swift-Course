//
//  BaseViewController.swift
//  UsingCompass
//
//  Created by GEORGE QUENTIN on 04/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import Compass
import LearningSwiftCourseExtensions

public class CompassBaseViewController: UIViewController {

    public func navigate(to route: String){
        do {
            try Navigator.navigate(urn: route)
        } catch {
            print("could not navigate to \(route)")
        }
    }
    
    public func handleRoute(_ url: URL, router: Router)  {
        guard let location = Navigator.parse(url: url) else {
            print("Location not found")
            return
        }
        router.navigate(to: location, from: self.navigationController!)
    }
 
    func navigatorLogin(){
        navigate(to :"login:George is In")
    }
    
    func navigatorHome(){
        navigate(to: "home:Home")
    }
    
    func navigatorBook(){
        navigate(to: "book:pages:PetterRabbit:24")
    }
    
    func navigatorProfile(){
        navigate(to: "profile:George Profile")
    }
    
    func navigatorLogout(){
        navigate(to: "logout")
    }
    
    func navigatorConfirm(){
        navigate(to: "logout//confirm")
    }
    
    var router = Router()
    
    func setupRouter(){
        router.routes = [
            "login:{username}": LoginRoute(),
            "home:{title}": HomeRoute(),
            "profile:{username}": ProfileRoute(),
            "book:pages:{name}:{amount}": BookRoute(),
            "logout": LogoutRoute()
        ]
        print( Navigator.routes)
        print(router.routes)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //disableNavBackButton()
        self.addMenuButton( with: self, selector: #selector(tapped) )
        setupRouter()
    }
   
    
    func changeBackButton (){
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
   

    
    @objc func tapped ( _ sender: UIBarButtonItem) {
        print("Tapped")
        
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
