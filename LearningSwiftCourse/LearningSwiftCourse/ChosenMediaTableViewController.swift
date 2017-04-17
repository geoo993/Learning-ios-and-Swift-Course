//
//  NewTableViewController.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 15/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit


class ChosenMediaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var media = String()
    var chosenMediaTitle = String()
    var productShown = [Bool]()
 
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.randomColor()
        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.navigationItem.title = media
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension 
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let product = MediaLayers.getProducts[fromIndexPath.row]
        MediaLayers.getProducts.remove(at: fromIndexPath.row)
        MediaLayers.getProducts.insert(product, at: to.row)
        self.tableView.reloadData()
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            MediaLayers.getProducts.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell") else 
        { 
            print("No Cell found"); 
            return 0.0 
        }
        
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = size.height
        return height //200.0;//Choose your custom row height
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.productShown[indexPath.row] == false {
            
            //cell.alpha = 0.0
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -300, 50, 0.0)
            cell.layer.transform = rotationTransform
            
            let resetToOriginalTransform = CATransform3DIdentity
            
            UIView.animate(withDuration: 1.0) { 
                //cell.alpha = 1.0
                cell.layer.transform =  resetToOriginalTransform
            }
            
            self.productShown[indexPath.row] = true
        }
    }
   
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        self.tableView = tableView
        return 1
     }
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.tableView = tableView
        return MediaLayers.getProducts.count
    }
     
     
    
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView = tableView
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as? MediaTableViewCell
            //let cell = tableView.dequeueReusableCellWithIdentifier("NewCell") as? aCell 
            else 
        { 
            print("No Cell found"); 
            return UITableViewCell()
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        let product = MediaLayers.getProducts[indexPath.row]
        cell.titleLabel.text = "\(product.title) (\(product.year))"
        
        cell.descriptionLabel.text = product.description
        cell.descriptionLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let img = product.image
        cell.imgView.image = img
        
        
        return cell
    }
    

    
    //performSegueWithIdentifier(identifier: "", sender: AnyObject?)
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
  
        if let identifier = segue.identifier {
            
            switch identifier {
                case "Show Detail":
                    
                    guard 
                    let cell = sender as? UITableViewCell,
                    let indexPath : IndexPath = self.tableView.indexPath(for: cell),
                        //let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow,
                    let destinationViewController = segue.destination as? ChosenMediaDetailedViewController else { print("Cant Page View Controller or index path is wrong"); return }
                    
                    destinationViewController.heading = chosenMediaTitle
                    destinationViewController.titleText = MediaLayers.getProducts[indexPath.row].title
                    destinationViewController.image = MediaLayers.getProducts[indexPath.row].image
                    destinationViewController.descriptionText = MediaLayers.getProducts[indexPath.row].description
         
            default:
                print("No Identifier")
                break
            }
            
          
        }
        
    }
 
    
    
}
