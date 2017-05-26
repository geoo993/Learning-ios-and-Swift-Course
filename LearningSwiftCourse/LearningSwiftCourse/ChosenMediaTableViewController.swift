//
//  NewTableViewController.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 15/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//  //section sorted from http://stackoverflow.com/questions/41646933/how-do-you-sort-data-in-a-tableview-alphabetically-by-section-using-a-custom-mod
//
//  rounded uitable view
//  http://stackoverflow.com/questions/6216839/how-to-add-spacing-between-uitableviewcell

import Foundation
import UIKit


class ChosenMediaTableViewController: UITableViewController, AddingDelegate 
{

    var media = String()
    var chosenMediaTitle = String()
    var productShown = [Bool]()
    var sections = [[Product]]()
 
 
    func updateSections() {
        sections = MediaLayers.sortedFirstLetters.map { firstLetter in
                return MediaLayers.getProducts
                    .filter { $0.titleFirstLetter == firstLetter } // only names with the same first letter in title
                    .sorted { $0.title < $1.title } // sort them
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.title = media
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension 
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItems?[0] = self.editButtonItem
        //self.navigationItem.rightBarButtonItems?[1].isEnabled = true
        //self.navigationItem.rightBarButtonItems?[1].tintColor = nil
        
        updateSections()
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - AddingDelegate
    func newEntryAdded(newEntryTitle:String, newEntryImage: UIImage, newEntryDscription: String) {
        print("title added: \(newEntryTitle), description added: \(newEntryDscription)")
        
        let product = Product(title: newEntryTitle, description: newEntryDscription, image: newEntryImage, year: 2010, rating: Rating.Ok, genres: [Genres.None])
        
        MediaLayers.getProducts.append(product)
        updateSections()
        self.tableView.reloadData() 
    }

    // MARK: - Table view data source and Side List in tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return MediaLayers.sortedFirstLetters //Side Section title
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return MediaLayers.sortedFirstLetters[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return MediaLayers.sortedFirstLetters[section]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 /*section == 0 ? 0 : 30 // section 1 and above have 50 section height */
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as? MediaTableViewCell
            else 
        { 
            print("No Cell found"); 
            return UITableViewCell()
        }
        cell.isUserInteractionEnabled = true
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        cell.tag = indexPath.row
        
        let product = sections[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = "\(product.title) (\(product.year))"
        
        cell.descriptionLabel.text = product.description
        cell.descriptionLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        cell.imgView.image = product.image
        
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
            
            sections[indexPath.section].remove(at: indexPath.row)
            //MediaLayers.getProducts.remove(at: indexPath.row)
            // Delete the row from the data source
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
        self.tableView.reloadData()  
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let product = sections[fromIndexPath.section][fromIndexPath.row]
        sections[fromIndexPath.section].remove(at: fromIndexPath.row)
        sections[to.section].insert(product, at: to.row)
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Product Cell") else 
        { 
            print("No Cell found"); 
            return 0.0 
        }
        
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let height = size.height
        
        return height 
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.productShown[indexPath.row] == false {
            
            cell.alpha = 0.2
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -300, 50, 0.0)
            cell.layer.transform = rotationTransform
            
            let resetToOriginalTransform = CATransform3DIdentity
            
            UIView.animate(withDuration: 1.0) { 
                cell.alpha = 1.0
                cell.layer.transform =  resetToOriginalTransform
            }
            
            self.productShown[indexPath.row] = true
        }
        
    }
 
    
    //performSegueWithIdentifier(identifier: "", sender: AnyObject?)
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
  
        if let identifier = segue.identifier {
            
            switch identifier {
                case "ShowDetailSegue":
                    
                    guard 
                    let cell = sender as? UITableViewCell,
                    let indexPath : IndexPath = self.tableView.indexPath(for: cell),
                    let destinationViewController = segue.destination as? ChosenMediaDetailedViewController else { 
                        print("Cannot go to Detailed Media View Controller or index path is wrong"); return 
                    }
                    
                    let product = sections[indexPath.section][indexPath.row]
                    destinationViewController.heading = chosenMediaTitle
                    destinationViewController.titleText = product.title
                    destinationViewController.image = product.image
                    destinationViewController.descriptionText = product.description
                    print("Show details")
                case "AddMediaSegue":
                    
                    guard let addMediaViewController = segue.destination as? AddMediaViewController else { 
                        print("Cannot go to Add Media View Controller "); 
                        return 
                    }
                    addMediaViewController.title = "Add New \(chosenMediaTitle)"
                    addMediaViewController.delegate = self
                    print("Add Media Segue")
                default:
                    print("No Identifier")
                    break
            }
            
          
        }
        
    }
 
    
    
}
