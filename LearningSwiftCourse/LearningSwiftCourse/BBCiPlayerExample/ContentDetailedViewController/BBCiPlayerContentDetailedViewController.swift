//
//  BBCiPlayerContentDetailedViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

class BBCiPlayerContentDetailedViewController: UIViewController, UINavigationBarDelegate {

    
    @IBAction func stopButton(_ sender: UINavigationItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playontvButton(_ sender: UINavigationItem) {
        print("Play on tv")
    }
    
    @IBOutlet weak var detailedContentTableView : UITableView!
    @IBOutlet weak var navBar : UINavigationBar!
    
    @IBOutlet weak var detailedContentImageView : UIImageView!
    @IBOutlet weak var detailedContentLogoImageView : UIImageView!
    @IBOutlet weak var detailedContentTitleLabel: UILabel!
    @IBOutlet weak var detailedContentDescriptionLabel: UILabel!
    @IBOutlet weak var detailedContentAvailableLabel: UILabel!
    @IBOutlet weak var detailedContentReleasedateLabel: UILabel!
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var navbarHeight : CGFloat = 84
    var usingNavigationController = false
    var currentContent : BBCiPlayerVideosItems?
    var mixedItems : [BBCiPlayerVideosItems] =  {
        let allchannelsItems = BBCiPlayerVideosItems.allChannelsItems()
        let shuffled = allchannelsItems.shuffled()
        let amount = shuffled.takeRandom(6)
        return amount
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.bbciplayerDark
        navBar.clearNavigationBarBackground(with: UIColor.clear)
        
        detailedContentTableView.tableFooterView = nil
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        displayCustomNavbar(display: usingNavigationController)
        setupCurrentContent()
        detailedContentTableView.reloadData()
    }
    
    func displayCustomNavbar (display : Bool){
        navBar.isHidden = display
    }
    func setupCurrentContent(){
        
        if let content = currentContent {
            detailedContentImageView.image = content.image
            detailedContentLogoImageView.image = BBCiPlayerVideosItems.Channels.allChannelsWithLogo[content.channel]
            detailedContentTitleLabel.text = content.title
            detailedContentDescriptionLabel.text = content.summary
        }
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
        currentContent = nil
        detailedContentTableView = nil
        navBar = nil
        detailedContentImageView = nil
        detailedContentLogoImageView = nil
        detailedContentTitleLabel = nil
        detailedContentDescriptionLabel = nil
        detailedContentAvailableLabel = nil
        detailedContentReleasedateLabel = nil
    }

}


// MARK: - Table view data source and UITableViewDelegate
extension BBCiPlayerContentDetailedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mixedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedContentTableViewCell", for: indexPath) as! BBCiPlayerContentDetailedTableViewCell
        
        cell.customSeperatorLine(withColor: UIColor.gray, separatorHeight: 0.4)
        cell.contentImageView.image = mixedItems[indexPath.row].image
        cell.contentTitleLabel.text = mixedItems[indexPath.row].title
        cell.contentDescriptionLabel.text = mixedItems[indexPath.row].summary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailedContentImageView.image = mixedItems[indexPath.row].image
        detailedContentLogoImageView.image = BBCiPlayerVideosItems.Channels.allChannelsWithLogo[mixedItems[indexPath.row].channel]
        detailedContentTitleLabel.text = mixedItems[indexPath.row].title
        detailedContentDescriptionLabel.text = mixedItems[indexPath.row].summary
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.25//CGFloat.leastNormalMagnitude 
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    
}

