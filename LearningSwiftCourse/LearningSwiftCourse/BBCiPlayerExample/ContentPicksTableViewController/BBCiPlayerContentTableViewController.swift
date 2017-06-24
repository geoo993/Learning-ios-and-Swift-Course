//
//  BBCiPlayerContentTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class BBCiPlayerContentTableViewController: UIViewController {

    @IBAction func stopButton(_ sender: UINavigationItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playontvButton(_ sender: UINavigationItem) {
        print("Play on tv")
    }
    
    @IBOutlet weak var tableView : UITableView!
    
    var titleName : String = ""
    var mixedItems : [BBCiPlayerVideosItems] =  {
        
        let allchannelsItems = BBCiPlayerVideosItems.allChannelsItems()
        let shuffled = allchannelsItems.shuffled()
        let amount = shuffled.take(10)
        return amount
    }()
    
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        tableView = nil
    }

}

// MARK: UITableViewDataSource
extension BBCiPlayerContentTableViewController: UITableViewDataSource {
    
    // If user changes text, hide the tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mixedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableViewCell") as! BBCiPlayerContentTableViewCell
       
        let captionText = mixedItems[indexPath.row].caption.rawValue
        cell.customSeperatorLine(withColor: UIColor.gray, separatorHeight: 0.4)
        cell.imageHeadingView.image = mixedItems[indexPath.row].image
        cell.imageHeadingLabel.text = captionText
        cell.titleLabel.text = mixedItems[indexPath.row].title
        cell.descriptionLabel.text = mixedItems[indexPath.row].summary
        
        cell.imageHeadingLabel.backgroundColor = (captionText == "") ? UIColor.clear : UIColor.bbciplayerPink()
        
        return cell
    }
    

}


// MARK: - UITableViewDelegate
extension BBCiPlayerContentTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
       
        let bundle = Bundle(identifier: "co.lexilabs.LearningSwiftCourse")
        let storyboard = UIStoryboard(name: "BBCiPlayerMain", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "BBCiPlayerContentDetailedViewController") as! BBCiPlayerContentDetailedViewController
        
        vc.usingNavigationController = true
        vc.currentContent = mixedItems[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true) 
        
        
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
