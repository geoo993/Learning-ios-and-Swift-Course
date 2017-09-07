//
//  DetailViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AnimatableDetailViewController: UIViewController {
  
    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
  
    var hamburgerView: AnimatableHamburgerView?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the drop shadow from the navigation bar
        navigationController!.navigationBar.clipsToBounds = true
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hamburgerViewTapped))
        hamburgerView = AnimatableHamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        
        
    }
  
    @objc func hamburgerViewTapped() {
        let navigationController = parent as! UINavigationController
        let containerViewController = navigationController.parent as! AnimatableSideMenuContainerViewController
        containerViewController.hideOrShowMenu(show: !containerViewController.showingMenu, animated: true)
    }
  
    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem {
                view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
                backgroundImageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
            }
        }
    }
  
}
