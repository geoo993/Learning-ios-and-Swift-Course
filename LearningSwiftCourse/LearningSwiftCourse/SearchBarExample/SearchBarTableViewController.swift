//
//  SearchBarTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=XtiamBbL5QU

import UIKit
import LearningSwiftCourseExtensions

class SearchBarTableViewController: UITableViewController {

    @IBAction func homeBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
    }
    
    @IBAction func searchBarButton(_ sender: UIBarButtonItem) {
        setupResultsTableView()
    }
    
    var colorNamesItems = {
        return ColorsCSS.cssString.filter{ $0 != "" }.sorted()
    }()
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Mark: - Search bar controller and another table view controller
    var searchController : UISearchController?
    var resultsTableViewController = UITableViewController()
    
    //Mark: - Search bar 
    var searchTextsColor = UIColor.systemsBlueColor
    var searchBarFiltered:[String] = []
    var searchBar: UISearchBar?
    var selectedColorFromSearch = 0 
    
//    func setupHomeNavigationbarItem(){
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchButtonTapped))
//        //navigationController?.navigationBar.barTintColor = UIColor.blue
//    }
//    
//    @objc func searchButtonTapped(_ sender: UIBarButtonItem){
//        setupResultsTableView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.searchController = UISearchController(searchResultsController: self.resultsTableViewController)
        self.resultsTableViewController.tableView.dataSource = self
        self.resultsTableViewController.tableView.delegate = self
        
        //setupHomeNavigationbarItem()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        self.definesPresentationContext = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setupResultsTableView (){
        
        ///Type 1: use the custom search bar delegate
        self.searchBar = searchController?.searchBar
        self.searchBar?.delegate = self
        let color = searchTextsColor.withAlphaComponent(0.6)
        self.searchBar?.textField?.placeHolderColor = color
        self.searchBar?.textField?.placeHolderMagnifyingGlassColor = color
        self.searchBar?.textColor = searchTextsColor
        self.tableView.tableHeaderView = self.searchBar
        
        scrollToHeader()
        
        ///Type 2: use the searchController searchResultsUpdater delegate
//        self.tableView.tableHeaderView = searchController?.searchBar
//        self.searchController?.searchResultsUpdater = self
//        self.searchController?.dimsBackgroundDuringPresentation = false
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (tableView == self.resultsTableViewController.tableView) ? self.searchBarFiltered.count : self.colorNamesItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == self.resultsTableViewController.tableView) {
            let cell = UITableViewCell()
            cell.textLabel?.text = self.searchBarFiltered[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchbarCell", for: indexPath) as! SearchBarTableViewCell
            cell.titleTextLabel?.text = colorNamesItems[indexPath.row]
            cell.titleTextLabel.backgroundColor = UIColor.clear
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == self.resultsTableViewController.tableView) {
            let selection = self.searchBarFiltered[indexPath.row]
            
            scrollToSelectedRow(with: selection)
            
            cancelSearch()
        }
        
        if (tableView == self.tableView) {
            changeCellColor(at:indexPath.row)
        }
    }
    
    func scrollToSelectedRow(with colorName: String){
        
        if let index  = colorNamesItems.index(of: colorName) {
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            self.tableView.reloadData()
            
            selectedColorFromSearch = Int(index)
        }
        
    }
    
    func changeCellColor(at index:  Int){
        
        if index < colorNamesItems.count {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchbarCell", for: indexPath) as! SearchBarTableViewCell
            let colorName = colorNamesItems[index]
            let color = UIColor(hex: colorName)
            cell.titleTextLabel.text = colorName
            cell.titleTextLabel.textColor = color.getTextColor
            cell.titleTextLabel.backgroundColor = color
            
            self.tableView.reloadData()
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
        self.searchBarFiltered = []
        self.resultsTableViewController.tableView.reloadData()
        
    }
    
}

// MARK: UISearchBarDelegate
extension SearchBarTableViewController : UISearchBarDelegate {
    
    /**
     *  SearchBar Data source.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false;
        self.searchBar?.resignFirstResponder()
        
    }
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBarFiltered = colorNamesItems
            .filter( { $0.lowercased().contains( (searchBar.text?.lowercased())! )})
            .map{ $0 }
        
        self.resultsTableViewController.tableView.reloadData()
        
    }
    
}


// MARK: UISearchResultsUpdating
extension SearchBarTableViewController : UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        //filter through the colors
        searchBarFiltered = colorNamesItems
            .filter( { $0.lowercased().contains( (searchController.searchBar.text?.lowercased())! )})
        .map{ $0 }
        
        //update the results table view
        self.resultsTableViewController.tableView.reloadData()
    }
    
}

// Mark: - UIScrollViewDelegate
extension SearchBarTableViewController  {
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        changeCellColor(at: selectedColorFromSearch)
    }
}



