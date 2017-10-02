//
//  DogsTableViewController.swift
//  DogSearch
//
//  Created by GEORGE QUENTIN on 02/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

// https://www.youtube.com/watch?v=XtiamBbL5QU

import UIKit

public class DogsTableViewController: UITableViewController {

    @IBAction func homeBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
    }
    
    
    let dogs : [ (name:String, image:UIImage) ] = [
        ("BullDog", #imageLiteral(resourceName: "BullDog")),
        ("Poodle",#imageLiteral(resourceName: "Poodle_dog")),
        ("Labrador Retriever", #imageLiteral(resourceName: "Labrador_Retriever_dog")),
        ("German Shepherd",#imageLiteral(resourceName: "German_Shepherd_dog")),
        ("Rottweiler",#imageLiteral(resourceName: "Rottweiler_dog")),
        ("Beagle",#imageLiteral(resourceName: "beagle_dog")),
        ("Chihuahua",#imageLiteral(resourceName: "chihuahua_dog")),
        ("Chow Chow",#imageLiteral(resourceName: "Chow_Chow_dog")),
        ("Pit bull",#imageLiteral(resourceName: "pit-bull-dog")),
        ("English Sheepdog",#imageLiteral(resourceName: "sheep_dog")),
        ("Alaskan Malamute",#imageLiteral(resourceName: "Alaskan_Malamute_dog")),
        ("Bichon Frise",#imageLiteral(resourceName: "bichon_frise_dog")),
        ("Basset Hound",#imageLiteral(resourceName: "Basset_Hound_dog")),
        ("Border Collie",#imageLiteral(resourceName: "Border_Collie_dog")),
        ("Boxer",#imageLiteral(resourceName: "Boxer_dog"))
        ]
    
    var searchController : UISearchController!
    var searchBar: UISearchBar?
    var resultsTableViewController : DogsResultsTableViewController?
    var selectedItemFromSearch = 0 
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let storyboard = UIStoryboard(name: "DogsMain", bundle: nil)
        self.resultsTableViewController = storyboard.instantiateViewController(withIdentifier: "DogsResultsTableViewController") as? DogsResultsTableViewController
        
        
        if let resultsController = self.resultsTableViewController {
            
            resultsController.dogsViewController = self
            
            setupSearchController(with: resultsController)
            setupSearchBar()
            
            self.definesPresentationContext = true // to remove spacing at the top of tableview
            
            resultsController.tableView.reloadData()
        }
    }
    
    func setupSearchController(with viewController: UIViewController){
        
        self.searchController = UISearchController(searchResultsController: viewController)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = true
        
    }

    func setupSearchBar (){
        
        self.searchBar = self.searchController?.searchBar
        self.searchBar?.delegate = self
        //let color = UI.withAlphaComponent(0.6)
        
        let image = UIImage()
        
        // To change the background color
        self.searchBar?.searchBarStyle = .prominent
        self.searchBar?.backgroundImage = image
        self.searchBar?.barTintColor = UIColor.white
        
        
        // To add borders use the views layer property.
        //self.searchBar?.layer.borderColor = UIColor.blue.cgColor
        //self.searchBar?.layer.borderWidth = 1
        
        // If you want to add the corner radius to the searchBar:
        //self.searchBar?.layer.cornerRadius = 3.0
        //self.searchBar?.clipsToBounds = true
        
       
        // To change the searchIcon call the following method on the searchbar:
        //self.searchBar?.setImage(image, for: UISearchBarIcon.search, state: UIControlState.normal)
        
        // To change the cross:
        //self.searchBar?.setImage(image, for: UISearchBarIcon.clear, state: UIControlState.normal)

        // To change search bar textfield
        let color = UIColor.searchBarColor
        self.searchBar?.textField?.cornerRadius(with: color, value: 10)
        self.searchBar?.textField?.placeHolderColor = color
        self.searchBar?.textField?.placeHolderMagnifyingGlassColor = color
        self.searchBar?.textColor = color
        self.tableView.tableHeaderView = self.searchBar
        
        scrollToHeader()
    }
    
    func scrollToSelectedRow(with itemName: String){
        
        if let index  = self.dogs
            .map({ $0.name })
            .index(of: itemName) {
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            self.tableView.reloadData()
            
            selectedItemFromSearch = Int(index)
        }
        
    }
    
    func highlightCell(at index:  Int){
        
        if index < dogs.count {
            
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
        }
    }
    
    func scrollToTopOfTableView(){
        
        if (self.tableView.numberOfSections > 0 ) {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true);
        }
        self.tableView.setContentOffset(CGPoint(x:0, y: UIApplication.shared.statusBarFrame.height ), animated: true)
    }
    
    func scrollToHeader() {
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    
    func cancelSearch(){
        self.searchBar?.endEditing(true)
        self.searchBar?.text = nil;
        self.resultsTableViewController?.filteredDogs = []
        self.resultsTableViewController?.tableView.reloadData()
        
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

// MARK: - Table view data source and delegate
extension DogsTableViewController {
    

    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }

    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dogsCellIdentifier", for: indexPath) as? DogsTableViewCell else { return  DogsTableViewCell() }

        cell.cellImage.image = dogs[indexPath.item].image
        cell.cellTitleLabel.text = dogs[indexPath.item].name
        //cell.textLabel?.text = dogs[indexPath.item].name
        return cell
    
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Override to support conditional editing of the table view.
    override public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


}


extension DogsTableViewController: UISearchResultsUpdating {
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        // filter through the dogs
        self.resultsTableViewController?.filteredDogs = self.dogs
            .filter{ 
                $0.name.lowercased()
                    .contains( (self.searchController.searchBar.text ?? "")
                        .lowercased() ) 
        }
        
        // update results table view
        self.resultsTableViewController?.tableView.reloadData()
    }
    
}

// MARK: UISearchBarDelegate
extension DogsTableViewController : UISearchBarDelegate {
    
    /**
     *  SearchBar Data source.
     */
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true;
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false;
        self.searchBar?.resignFirstResponder()
        
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.resultsTableViewController?.filteredDogs = self.dogs
            .filter( { $0.name.lowercased()
                .contains( (searchBar.text ?? "").lowercased()) })
           
        self.resultsTableViewController?.tableView.reloadData()
        
    }
    
}

// Mark: - UIScrollViewDelegate
extension DogsTableViewController  {
    
    override public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        highlightCell(at: selectedItemFromSearch)
    }
}
