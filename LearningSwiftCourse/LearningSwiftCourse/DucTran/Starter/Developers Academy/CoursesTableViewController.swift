//
//  CoursesTableViewController.swift
//  Developers Academy
//
//  Created by Duc Tran on 11/27/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit
import SafariServices       // for SFSafariViewController
import LocalAuthentication  // for touch id authentication
import Social               // for facebook and twitter sharing

class CoursesTableViewController: UITableViewController
{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var programs: [Program] = [Program.TotalIOSBlueprint(), Program.SocializeYourApps()]
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the row height dynamic
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    
        displayWalkthroughs()
        
        // burger side bar menu
    }
    
    func displayWalkthroughs()
    {
        // Create the walkthrough screens
        let userDefaults = UserDefaults.standard
        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
        if !displayedWalkthrough {
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                self.present(pageViewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return programs.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs[section].courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Course Cell", for: indexPath) as! CourseTableViewCell
        
        let program = programs[indexPath.section]
        let courses = program.courses
        cell.course = courses[indexPath.row]
        
        return cell
    }
    
    // MARK: - Social Sharing
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        
        let course = programs[indexPath.section].courses[indexPath.row]
        
        let shareAction = UITableViewRowAction(style:UITableViewRowAction.Style.normal, title: "Share") { (action, indexPath) -> Void in
            let shareActionSheet = UIAlertController(title: nil, message: "Share with", preferredStyle: .actionSheet)
            
            // twitter sharing action
            let twitterShareAction = UIAlertAction(title: "Twitter", style: UIAlertAction.Style.default) { (action) -> Void in
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    // good to go, let's show the twitter composer
                    let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    tweetComposer?.setInitialText(course.description)
                    tweetComposer?.add(course.image)
                    
                    self.present(tweetComposer!, animated: true, completion: nil)
                } else {
                    // twitter isn't available. alert an error
                    self.alert("Twitter Unavaiable", msg: "Be sure to go to Settings > Twitter to set up your Twitter account")
                }
            }
            
            // facebook sharing action
            let facebookShareAction = UIAlertAction(title: "Facebook", style: UIAlertAction.Style.default) { (action) -> Void in
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                    // good to go, let's show the twitter composer
                    let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookComposer?.setInitialText(course.description)
                    facebookComposer?.add(course.image)
                    facebookComposer?.add(URL(string: course.programURL)!)
                    
                    self.present(facebookComposer!, animated: true, completion: nil)
                } else {
                    // twitter isn't available. alert an error
                    self.alert("Facebook Unavaiable", msg: "Be sure to go to Settings > Facebook to set up your Facebook account")
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            shareActionSheet.addAction(twitterShareAction)
            shareActionSheet.addAction(facebookShareAction)
            shareActionSheet.addAction(cancelAction)
            
            self.present(shareActionSheet, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
        return [shareAction]
    }
    
    func alert(_ title: String, msg: String)
    {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let program = programs[indexPath.section]
        let courses = program.courses
        let selectedCourse = courses[indexPath.row]
        
        self.performSegue(withIdentifier: "Show Course Detail", sender: selectedCourse)
    }
    
    // MARK: - Show Webpage with SFSafariViewController
    
    func showWebsite(_ url: String)
    {
        let webVC = SFSafariViewController(url: URL(string: url)!)
        webVC.delegate = self
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    // MARK: - Target / Action
    
    @IBAction func signupClicked(_ sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func loginClicked(_ sender: AnyObject)
    {
        authenticateUsingTouchID()
    }
    
    // MARK: - Touch ID authentication
    
    func authenticateUsingTouchID()
    {
        let authContext = LAContext()
        let authReason = "Please use Touch ID to sign in Developers Academy"
        var authError: NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success, error) -> Void in
                if success {
                    print("successfully authenticated")
                    // this is on a private queue off the main queue (asynchronously), if we want to do UI code, we must get back to the main queue
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tabBarController?.selectedIndex = 2    // go to the programs tab or sign in in your app
                    })
                } else {
                    if let error = error {
                        // again, this is off the main queue. need to back to the main queue to do ui code
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.reportTouchIDError(error as NSError)
                            // it's best to show other method to login (enter user name and password)
                        })
                    }
                }
            })
        } else {
            // device doesn't support touch id 
            print(authError?.localizedDescription as Any)
            
            // show other methods to login
        }
    }
    
    func reportTouchIDError(_ error: NSError)
    {
        switch error.code {
        case LAError.Code.authenticationFailed.rawValue:
            print("Authentication failed")
        case LAError.Code.passcodeNotSet.rawValue:
            print("passcode not set")
        case LAError.Code.systemCancel.rawValue:
            print("authentication was canceled by the system")
        case LAError.Code.userCancel.rawValue:
            print("user cancel auth")
        case LAError.Code.biometryNotAvailable.rawValue:
            print("user hasn't enrolled any finger with touch id")
        case LAError.Code.biometryNotAvailable.rawValue:
            print("touch id is not available")
        case LAError.Code.userFallback.rawValue:
            print("user tapped enter password")
        default:
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Course Detail" {
            let courseDetailTVC = segue.destination as! CourseDetailTableViewController
            courseDetailTVC.course = sender as? Course
        }
    }
}

extension CoursesTableViewController : SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}












