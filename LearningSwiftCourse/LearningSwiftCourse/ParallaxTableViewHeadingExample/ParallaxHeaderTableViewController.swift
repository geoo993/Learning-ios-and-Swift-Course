//
//  ParallaxHeadingTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/42953360/swift-how-to-do-add-an-header-with-parallax-effect-to-tableview
//https://www.youtube.com/watch?v=vIeZrhIjApg
//https://blog.frozenfirestudios.com/how-to-add-a-stretchy-flair-to-your-uicollectionview-e403822e0f33

import UIKit
import LearningSwiftCourseExtensions

class ParallaxHeaderTableViewController: UITableViewController {

    var headerView : UIView!
    var newHeaderLayer : CAShapeLayer!
    
    var containerView : SlideShowView? = nil
    let imageNames = ["autumnlandscape", "desert", "GoldenGateBridge", "happiness","japanvillage", "pexels", "treesfallredleaves", "bg-header"] 
    
    let colorItems = {
        return ColorsCSS.cssString.sorted()
    }()
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250)
        self.tableView.tableHeaderView  = ParallaxHeaderView(frame: parallaxViewFrame)
        self.tableView.tableHeaderView?.clipsToBounds = true
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        if containerView == nil {
            if let frame = tableView.tableHeaderView?.frame {
                let images = imageNames.compactMap{ UIImage(named: $0)! }
                
                containerView = SlideShowView(frame: frame, parentView: tableView.tableHeaderView!, images: images) 
                containerView?.moveToDistance = 30
                
                if let view = containerView {
                    tableView.tableHeaderView?.addSubview(view)
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        containerView?.animateImageViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! ParallaxHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colorItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parallax header cell", for: indexPath) as! ParallaxHeaderTableViewCell
        
        let index = indexPath.row
        let colorName = colorItems[index]
        let color = UIColor(hex: colorName)
        let hexValue = color.toHexString
        let redComponents = color.rgbValues.r.round(to: 2)
        let greenComponents = color.rgbValues.g.round(to: 2)
        let blueComponents = color.rgbValues.b.round(to: 2)
        let alphaComponents = color.rgbValues.a.round(to: 2)
        
        cell.colorLabel.text = colorName
        cell.colorHexLabel.text = hexValue
        cell.colorRGBLabel.text = "red: \(redComponents),   green:\(greenComponents),   blue\(blueComponents),   alpha:\(alphaComponents)"
        
        cell.colorLabel.textAlignment = (index % 2 == 0) ? .right : .left
        cell.colorHexLabel.textAlignment = (index % 2 == 0) ? .right : .left
        cell.colorRGBLabel.textAlignment = (index % 2 == 0) ? .right : .left
        
        cell.backgroundColor = color
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            dismiss(animated: true) { 
                print("view controller dismissed, now going to home page")
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
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
    
    func clearAll(){
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Parallax header view controller is \(#function)")
    }

}
