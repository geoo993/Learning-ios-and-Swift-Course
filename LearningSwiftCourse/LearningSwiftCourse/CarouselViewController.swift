//
//  CarouselViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {

    //Mark: - @IBOutlets and @IBAction
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addInterestButton: UIButton!
    @IBAction func addInterestButtonAction ( _ sender: UIButton){
        //print("New Interest")
    }
    
    @IBOutlet weak var userProfileImageButton: UIButton!
    @IBAction func userProfileImageButtonAction( _ sender: UIButton){
        //print("User profile image")
    }
    
    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    //Mark: - UICollectionviewDataSource
    var interests = Interest.createInterest()
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Mark: - Set cell width and content inset
    var contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) 
    var screenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
  
    //Mark: - Search bar active
    var searchActive : Bool = false
    var searchBarFiltered:[String] = []
    
    //Mark: - Scroll view elements
    var scrollOffset = CGPoint.zero
    
    //Mark: - viewDidLoad 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.randomColor()
        definesPresentationContext = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        // Cancel search bar color
        UIBarButtonItem.appearance().tintColor = UIColor.blue.withAlphaComponent(0.5)
        
        
        // Assumption is we're supporting a small maximum number of entries
        // so will set height constraint to content size
        // Alternatively can set to another size, such as using row heights and setting frame
        tableViewHeightConstraint.constant = tableView.contentSize.height
        //tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        
        tableView.reloadData()
    }
    
    struct StoryBoard{
        static let cellIdentifier = "Interest Cell"
    }
    
    deinit {
        print("Carousel view controller is \(#function)")
    }
}

// MARK: UISearchBarDelegate
extension CarouselViewController : UISearchBarDelegate {
  

    /**
     * Called when the user click on the view (outside the SearchBar).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        
        if touch.view != tableView
        {
            self.searchBar.endEditing(true)
            self.tableView.isHidden = true
        }
        
    }
    
    
    /**
     *  SearchBar Data source.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        searchBar.showsCancelButton = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.showsCancelButton = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //tableView.isHidden = true
        
        let text  = interests
            .filter( { $0.title.lowercased().contains( searchText.lowercased() )})
            .map{ $0.title }
        
        searchBarFiltered = text
        
        if(searchBarFiltered.count == 0){
            searchActive = false;
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            searchActive = true;
        }
        
        self.tableView.reloadData()
    }
    
}


// MARK: UITableViewDataSource
extension CarouselViewController: UITableViewDataSource {
    
    // If user changes text, hide the tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return searchBarFiltered.count
        }
        return interests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "table cell") as UITableViewCell!
        
        if(searchActive){
            cell.textLabel?.text = searchBarFiltered[indexPath.row]
        } else {
            cell.textLabel?.text = interests[indexPath.row].title
        }
        cell.textLabel?.font = searchBar.textFont

        tableViewHeightConstraint.constant = tableView.contentSize.height
        
        return cell
    }
}
    

// MARK: - UITableViewDelegate
extension CarouselViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        searchBar.text = searchBarFiltered[indexPath.row]
        tableView.isHidden = true
        searchBar.endEditing(true)
        
        var doScrollToCell = false
        var doScrollIndex = 0
        
        for (index,item) in interests.enumerated() {
            
            if (searchBar.text == item.title){
                doScrollToCell = true
                doScrollIndex = index
                break
            }
        }
        
        if doScrollToCell{
            
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let itemWidth = screenWidth - (contentInset.left * 2)
            let cellWidthIncludingSpacing = itemWidth + layout.minimumLineSpacing
            
            let xPosition = CGFloat(doScrollIndex) * cellWidthIncludingSpacing - collectionView.contentInset.left
            let yPosition = -collectionView.contentInset.top
            scrollOffset = CGPoint(x: xPosition, y: yPosition)
            self.collectionView.contentOffset = scrollOffset
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: - UICollectionViewDataSource
extension CarouselViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cellIdentifier, for: indexPath) as? InterestCollectionViewCell else {
            return InterestCollectionViewCell()
        }
        
        cell.interest = interests[indexPath.item]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CarouselViewController : UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        let itemWidth = screenWidth - (contentInset.left * 2)
        let itemHeight = layout?.itemSize.height ?? 300
        
        return CGSize(width: itemWidth , height: itemHeight) 
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return contentInset
    }
}

// MARK: - UIScrollViewDelegate
extension CarouselViewController : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = screenWidth - (contentInset.left * 2)
        let cellWidthIncludingSpacing = itemWidth + layout.minimumLineSpacing
        
        scrollOffset = targetContentOffset.pointee
        let index = (scrollOffset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        let xPosition = roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left
        let yPosition = -scrollView.contentInset.top
        
        scrollOffset = CGPoint(x: xPosition, y: yPosition)
        
        targetContentOffset.pointee = scrollOffset
        
    }
    
}

