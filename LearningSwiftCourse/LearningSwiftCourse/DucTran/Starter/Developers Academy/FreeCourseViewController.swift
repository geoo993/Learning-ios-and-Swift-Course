//
//  FreeCourseViewController.swift
//  Developers Academy
//
//  Created by Duc Tran on 11/27/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit
import SafariServices

class FreeCourseViewController: UITableViewController
{
    var courses: [Course]!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let course1 = Course(title: "1. Master the Swift Programming Language", description: "Everything you need to learn about Swift to get up and running with iOS Development", image: UIImage(named: "19")!, programURL: "http://www.developersacademy.io/4courses")
        
        let course15 = Course(title: "15. Build Snapchat Clone wt Parse", description: "Create self-destructive photo and video messaging app like Snapchat. Learn Parse, Instant Messaging and Push Notification", image: UIImage(named: "15")!, programURL: "http://www.developersacademy.io/")
        
        courses = [course1, course15]
        
        // Make the row height dynamic
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Course Cell", for: indexPath as IndexPath) as! CourseTableViewCell
    
        cell.course = courses[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let course = courses[indexPath.row]
        let url = course.programURL
        
        showWebsite(url: url)
    }
    
    // MARK: - Show Webpage with SFSafariViewController
    
    func showWebsite(url: String)
    {
        let webVC = SFSafariViewController(url: NSURL(string: url)! as URL)
        webVC.delegate = self
        
        self.present(webVC, animated: true, completion: nil)
    }

}

extension FreeCourseViewController : SFSafariViewControllerDelegate
{
    @nonobjc func safariViewControllerDidFinish(controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
