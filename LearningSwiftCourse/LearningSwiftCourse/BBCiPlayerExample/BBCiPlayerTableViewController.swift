//
//  BBCiPlayerTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/31582378/ios-8-swift-tableview-with-embedded-collectionview
//https://www.raywenderlich.com/129059/self-sizing-table-view-cells

import UIKit

class BBCiPlayerTableViewController: UITableViewController {

    let mainSections = ["My Channel","Most Popular","New Series","Comedy Picks", "Documentary Picks"]
    
    var mainMenuData : [[BBCiPlayerVideosItems]] = {
        return [
            //After My Channel
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None, videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After Most Popular
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After New Series
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After Comedy Picks
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            
            //After Documentary Picks
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")]
        ]
    }()
    
    var cellHeight : CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.layoutSubviews()
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

// MARK: - Table view data source and UITableViewDelegate
extension BBCiPlayerTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mainSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iplayerTableViewCell", for: indexPath)
            as! BBCiPlayerTableViewCell
        //cell.tag = indexPath.section
        cell.collectionView.reloadData()
        cell.collectionData = mainMenuData[indexPath.section]
        //cell.collectionView.collectionViewLayout.invalidateLayout()
        //cell.backgroundColor = UIColor.randomColor()
        
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
 
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return mainSections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // section 1 and above have 50 section height */
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "iplayerTableViewCell") as! BBCiPlayerTableViewCell 
        //let size: CGSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        //let height = size.height
        //return UITableViewAutomaticDimension
        
        let numberOfItemsInCell = mainMenuData[indexPath.section].count
        let inPairs = numberOfItemsInCell / 2
        
        return cellHeight * CGFloat(inPairs)
    }
    
    /*
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
 */
    
}
