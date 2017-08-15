//
//  CarouselViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=JG7mWFcU0vk

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

//    //Mark: - UICollectionviewDataSource
//    weak var interest : Interest? {
//        willSet {
//            if newValue != nil { 
//                print(newValue)
//                print("target set to nil") 
//                myTitle = newValue?.title ?? ""
//                //interestTitles = interests.map{ $0.title } 
//                //interestDescription  = interests.map{ $0.description } 
//                //interestFeatureImages = interests.map{ $0.featuredImage } 
//            }
//            else { 
//                print("target set to view") 
//            }
//        }
//    }
   
    lazy var interests : [Interest?]? =
    {
        return [ 
            Interest(title: "We Love Traveling Around the World", description: "We Love backpack and adventures! We walked to Artartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea.", featuredImage: "SnowyCartoonCave"),
            Interest(title: "Romance Stories", description: "We Love romantic stories, We Spend all our day taking care of every precious little things we still have available in this extraordary world. We just want to keep empowering people to continue to love one another.", featuredImage: "pexels"),
            Interest(title: "We Love Games", description: "We Love playing and jaming together in our games room! Playing board games, drinking, laughing, going against each other and enjoying some the most amazing games of our current generation.", featuredImage: "autumnlandscape"),
            Interest(title: "We Love Racing", description: "Cars and aircrafts and boats are our favourite racing vehicles. We love going to the mountains racing down the curvy slides and dangling along the coastline with our racers. Totally Amazing!", featuredImage: "desert"),
            Interest(title: "I Love Words", description: "I wrote a book once about my lover and the child we had. It was the greatest book I've ever written and it turned out to be the greatest fictional story ever written. Even though the words in that book explained the tradegy that happened throughout my short loving time with my wife.", featuredImage:  "treesfallredleaves")
        
        ]
    }()
    
    //weak var interest : Interest?
    var interestTitles : [String]?
    var interestDescription : [String]?
    var interestFeatureImages : [String]?
    

    func setupInterests(){
        
        //print(interest)
        if interests != nil {
            interestTitles = interests?.map{ $0!.title } 
            interestDescription  = interests?.map{ $0!.description } 
            interestFeatureImages = interests?.map{ $0!.featuredImage } 

            interests = nil
        }
        
    }
    
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

        setupInterests()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.random
        definesPresentationContext = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    
    func clearAll(){
        interests = nil
        interestTitles = nil
        interestDescription  = nil
        interestFeatureImages = nil
        view.removeEverything()
    }
    
    deinit {
        
        clearAll()
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

        let texts = interestTitles?
            .filter( { $0.lowercased().contains( searchText.lowercased() )}) ?? [String]()
        
        searchBarFiltered = texts
        
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
        return interestTitles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "table cell") as UITableViewCell!
        
        if(searchActive){
            cell.textLabel?.text = searchBarFiltered[indexPath.row]
        } else {
            cell.textLabel?.text = interestTitles?[indexPath.row]
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
        
        if let allInterest = interestTitles {
        
            for (index,item) in allInterest.enumerated() {
                
                if (searchBar.text == item){
                    doScrollToCell = true
                    doScrollIndex = index
                    break
                }
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
        return interestTitles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cellIdentifier, for: indexPath) as? InterestCollectionViewCell else {
            return InterestCollectionViewCell()
        }
        
        cell.interestTitle = interestTitles?[indexPath.item]
        cell.interestFeatureImage = UIImage(named: interestFeatureImages?[indexPath.item] ?? "" ) ?? UIImage(named: "noImage") 
        
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

