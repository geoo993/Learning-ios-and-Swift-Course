//
//  StretchyHeaderTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//http://blog.matthewcheok.com/design-teardown-stretchy-headers/
//https://blog.frozenfirestudios.com/how-to-add-a-stretchy-flair-to-your-uicollectionview-e403822e0f33
//https://www.youtube.com/watch?v=lML5XMLrZEk
//https://www.youtube.com/watch?v=7pbU3BRqa7A

import UIKit

class StretchyHeaderTableViewController: UITableViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerDateLabel: UILabel!
    
    
    let items = [  
        NewStretchyHeaderItem(continent: .World, summary: "Climate change protests, divestments meet fossil fuels realities"),
        NewStretchyHeaderItem(continent: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewStretchyHeaderItem(continent: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewStretchyHeaderItem(continent: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewStretchyHeaderItem(continent: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewStretchyHeaderItem(continent: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewStretchyHeaderItem(continent: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewStretchyHeaderItem(continent: .Europe, summary: "'One million babies' created by EU student exchanges"),
        ]
    
    func setDate(){
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        // "October 8, 2016"
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        headerDateLabel.text = formatter.string(from: currentDateTime)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let kTableHeaderHeight: CGFloat = 250.0  
    let kTableHeaderCutAway: CGFloat = 50.0  
    
    var useCutOff = true
    var headerView: UIView! 
    var headerCutOffLayer : CAShapeLayer!
    var containerView : SlideShowView? = nil
    let imageNames = ["autumnlandscape", "desert", "GoldenGateBridge", "happiness","japanvillage", "pexels", "treesfallredleaves"] 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDate()
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
       
        let effectiveHeight = useCutOff ? kTableHeaderHeight-kTableHeaderCutAway/2 : kTableHeaderHeight
        
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        if useCutOff {
            headerCutOffLayer = CAShapeLayer()
            headerCutOffLayer.fillColor = UIColor.black.cgColor
                
            headerView.layer.mask = headerCutOffLayer
        }
       
        updateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*
        if containerView == nil {
            if let frame = tableView.tableHeaderView?.frame {
                let images = imageNames.flatMap{ UIImage(named: $0)! }
                
                containerView = SlideShowView(frame: frame, parentView: tableView.tableHeaderView!, images: images) 
                containerView?.moveToDistance = 30
                
                if let view = containerView {
                    tableView.tableHeaderView?.addSubview(view)
                }
            }
        }
        */
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //containerView?.animateImageViews()
    }
   
    func updateHeaderView() {  
        
        let effectiveHeight = useCutOff ? kTableHeaderHeight-kTableHeaderCutAway/2 : kTableHeaderHeight
        
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            
            let effectiveOffsetheight = useCutOff ? -tableView.contentOffset.y + kTableHeaderCutAway/2 : -tableView.contentOffset.y
            
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = effectiveOffsetheight
        }
        
        headerView.frame = headerRect
    
        if useCutOff {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: headerRect.width, y: 0))
            path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
            path.addLine(to: CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
            headerCutOffLayer?.path = path.cgPath
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        updateHeaderView()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stretchyCell", for: indexPath)
        as! StretchyHeaderTableViewCell
        
        cell.newsItem = items[indexPath.row]
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */ 
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


}
