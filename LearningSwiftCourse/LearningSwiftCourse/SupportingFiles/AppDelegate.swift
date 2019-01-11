//
//  AppDelegate.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//


import UIKit
import LearningSwiftCourseExtensions

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        /*
         window = UIWindow(frame: UIScreen.main.bounds)
         window?.makeKeyAndVisible()
         
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         let homeVC = YoutubeHomeCollectionViewController(collectionViewLayout: layout)
         let navigator = UINavigationController(rootViewController:homeVC)
         navigator.navigationBar.barTintColor = UIColor.topMenuRedColor()
         
         //get rid of black bar underneath navigation bar
         navigator.navigationBar.shadowImage = UIImage()
         navigator.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
         window?.rootViewController = navigator
         
         application.statusBarStyle = .lightContent
         
         let statusBarBackgroundView = UIView(frame: CGRect.zero)
         statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
         window?.addSubview(statusBarBackgroundView)
         window?.addConstraints(with: "H:|[v0]|", views: statusBarBackgroundView)
         window?.addConstraints(with: "V:|[v0(20)]", views: statusBarBackgroundView)
         */
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
