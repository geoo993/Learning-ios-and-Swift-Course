//
//  UIViewController+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

public extension UIViewController {
//    var controllerAppDelegate : AppDelegate? {
//        return UIApplication.shared.delegate as? AppDelegate
//    }
    
    func disableNavBackButton(){
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
        //self.navigationItem.setLeftBarButton(nil, animated: true)
        //self.navigationItem.leftBarButtonItems = []
    }
    
    func addMenuButton(with target: Any?, selector: Selector?){
        var image = UIImage(named: "hamburger_icon")
        image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        //create a new button
        let button: UIButton = UIButton(type: .system)
        //set image for button
        button.setImage(image, for: UIControlState.normal)
        //add function for button
        button.addTarget(target, action: selector!, for: .touchUpInside)
        //set frame
        button.frame = CGRect(x:0, y:0, width:30, height:30)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        navigationItem.rightBarButtonItem = barButton
        
        //let menu1 = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: selector)
        //let menu2 = UIBarButtonItem(image: image, style: .plain, target: target, action: selector  )
        //navigationItem.rightBarButtonItem = menu2

    }
    
}
