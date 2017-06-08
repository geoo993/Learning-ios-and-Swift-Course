//
//  StorySmartiesMenuViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class StorySmartiesMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension StorySmartiesMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Story Shelf Cell", for: indexPath)
        }else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Settings Cell", for: indexPath)
        }
        else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Logout Cell", for: indexPath)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 2) {//hit log out button
            dismiss(animated: true) { 
                print("SWRevealViewController dismissed, now going to home page")
            }
        }
        
    }
    
}
