//
//  MenuViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AnimatableSideMenuViewController: UITableViewController {
  
    lazy var menuItems: NSArray = {
        guard let path = Bundle.main.path(forResource: "MenuItems", ofType: "plist") else { 
            print("File does not exist")
            return []
        }
        return NSArray(contentsOfFile: path)!
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the drop shadow from the navigation bar
        navigationController!.navigationBar.clipsToBounds = true
    
        print(menuItems)
        
        (navigationController!.parent as! AnimatableSideMenuContainerViewController).menuItem = (menuItems[0] as! NSDictionary)
    }
  
    // MARK: UITableViewDelegate
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        (navigationController!.parent as! AnimatableSideMenuContainerViewController).menuItem = menuItem
        
    }
  
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        // adjust row height so items all fit into view
        return max(80, (view.bounds.size.height) / CGFloat(menuItems.count))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! AnimatableSideMenuItemCell
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        cell.configureForMenuItem(menuItem: menuItem)
        return cell
    }
  
}
