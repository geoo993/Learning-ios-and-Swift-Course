//
//  TableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class MediaTableViewController: UITableViewController {

    @IBAction func homeBarItem(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true) { 
            print("media table view controller dismissed, now going to home page")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.title = "Media"
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItems?[0] = self.editButtonItem
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Media Header"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "Media Footer"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MediaLayers.mediaTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"Media Type Cell", for: indexPath)
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        let media = MediaLayers.mediaTypes[indexPath.row]
        let img = media.image.imageWithSize(size: CGSize(width: 100,height: 100), extraMargin: 0)
        
        cell.textLabel?.text = media.title
        cell.detailTextLabel?.text = media.description
        cell.imageView?.image = img        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            MediaLayers.mediaTypes.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let product = MediaLayers.mediaTypes[fromIndexPath.row]
        MediaLayers.mediaTypes.remove(at: fromIndexPath.row)
        MediaLayers.mediaTypes.insert(product, at: to.row)
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
  
        guard 
            let indexPath : IndexPath = self.tableView.indexPathForSelectedRow as IndexPath?,
            let tableViewController = segue.destination as? UITableViewController,//makeing sure that it is a UITableViewController
            let destinationViewController = tableViewController as? 
            ChosenMediaTableViewController
            else { 
                print("Cant Find Product Table View Controller or index path is wrong"); 
                return 
        }
        
        destinationViewController.chosenMediaTitle = MediaLayers.layers[indexPath.row]
        
        let title = MediaLayers.mediaTypes[indexPath.row].title
        destinationViewController.media = title
        
        guard let productLine = MediaLayers.chosingMedia(mediaChosen: title) else { print("Couldnd find product line "); return }
        
        MediaLayers.getProducts.removeAll()
        MediaLayers.getProducts = productLine.products
        
        destinationViewController.productShown.removeAll()
        destinationViewController.productShown = [Bool](repeating: false, count: productLine.products.count)
        
        
    }
    
}
