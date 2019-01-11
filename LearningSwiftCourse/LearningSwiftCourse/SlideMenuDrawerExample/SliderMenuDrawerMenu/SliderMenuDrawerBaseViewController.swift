//
//  SliderMenuDrawerBaseViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class SliderMenuDrawerBaseViewController: UIViewController, SlideMenuDelegate {
    
    var arrayMenuOptions : [ (title:String, color:String) ] = {
        return [ 
            (title:"User", color:"Blue"),
            (title:"Create", color:"Yellow"),
            (title:"Play", color:"Orange"),
            (title:"Upload", color:"Brown"),
            (title:"Options", color:"Cyan"),
            (title:"Settings", color:"Green")
            ]
    }()
    
    func sliderMenuDrawerViewControllers () -> [SliderMenuDrawerCustomViewController?] {
        
        //let bundleIdentifier =  Bundle.main.bundleIdentifier
        let defaultBundleID = "co.lexilabs.LearningSwiftCourse"
        let bundle = Bundle(identifier: defaultBundleID)
        let storyboard = UIStoryboard(name: "SliderMenuDrawerMain", bundle: bundle)
        return [0..<arrayMenuOptions.count].flatMap{ $0 }.map{ (index) -> SliderMenuDrawerCustomViewController? in
            let destination = storyboard.instantiateViewController(withIdentifier: "SliderMenuDrawerCustomViewController") as? SliderMenuDrawerCustomViewController
            let title = arrayMenuOptions[index].title
            let color = UIColor(hex: arrayMenuOptions[index].color)
            destination?.restorationIdentifier = title
            destination?.title = title
            //destViewController.navigationController?.title = "User"
            destination?.view.backgroundColor = color
            return destination
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupHomeNavigationbarItem()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupHomeNavigationbarItem(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(homeTapped))
    }
    
    @objc func homeTapped(_ sender : UIBarButtonItem){
        self.dismiss(animated: true, completion: {
            print("view controller dismissed, now going to home page")
        })
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int) {
        //let topViewController : UIViewController = self.navigationController!.topViewController!
        //print("The Top View Controller is : \(topViewController) \n", terminator: "")
        //self.navigationController?.viewControllers.flatMap{ print("View controllers in stack: ", $0)}
        
        let preferredIndex = index - 1
        
        switch(index){
        case 0:
            print("Apple\n", terminator: "")
            
            if (self.navigationController?.viewControllers.count)! > 1 {
                self.navigationController!.popToRootViewController(animated: true)
                //self.navigationController!.pushViewController(topViewController, animated: true)
            }
            
            break
        case 1:
            print("User\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)
            
            break
        case 2:
            print("Create\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)
            
            break
        case 3:
            print("Play\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)
            
            break
        case 4:
            print("Upload\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)
            
            break
        case 5:
            print("Options\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)
            
            break
        case 6:
            print("Settings\n", terminator: "")
            self.openViewControllerBasedOnIdentifier(with: preferredIndex,strIdentifier: arrayMenuOptions[preferredIndex].title)

            break
        default:
            print("default\n", terminator: "")
        }
    }
    
    //set next view controller when cell is selected
    func openViewControllerBasedOnIdentifier(with index: Int, strIdentifier: String){
        //let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        let topViewController : UIViewController = self.navigationController!.topViewController!
        if let destViewController = sliderMenuDrawerViewControllers()[index] {
            if (topViewController.restorationIdentifier == destViewController.restorationIdentifier){
                print("Same View Controller")
            } else {
                self.navigationController!.pushViewController(destViewController, animated: true)
                destViewController.mainLabel?.text = strIdentifier
            }
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
        //btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState.normal)
        btnShowMenu.setImage(UIImage(named: "menu_black"), for: UIControl.State.normal)
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(SliderMenuDrawerBaseViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }

    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        return defaultMenuImage;
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        //show slider menu
        let menuVC : SliderMenuDrawerMenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "SliderMenuDrawerMenuViewController") as! SliderMenuDrawerMenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        menuVC.view.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            }, completion:nil)
    }
    func clearAll(){
        self.view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Slider Menu Drawer Base view controller is \(#function)")
    }
}
