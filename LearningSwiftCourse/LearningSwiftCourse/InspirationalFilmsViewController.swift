//
//  InspirationalFilmsViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class InspirationalFilmsViewController: UIViewController {

    public static var updateInspirationalFilm = BehaviorSubject(value: "")
    var disposeBag = DisposeBag()
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Mark: - InspirationalFilms sorted
    var inspirationalFilms : [InspirationalFilms] = {
        return InspirationalFilms
            .inspirationalFilmsList()
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == ComparisonResult.orderedAscending }
    }()
    
    
    //Mark: - Set cell width and content inset
    var contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) 
    var screenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    //Mark: - Search bar active
    var searchActive : Bool = false
    var searchBarFiltered:[String] = []
    
    //Mark: - Scroll view elements
    var scrollOffset = CGPoint.zero
    
    //Mark: - @IBOutlets and @IBAction
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("Inspirational Films view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var filmsImagesScrollView: InspirationalFilmsImagesScrollView!
    @IBOutlet weak var filmsImagesPageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var inspirationalFilmsTitle: UILabel!
    @IBOutlet weak var inspirationalFilmsYear: UILabel!
    @IBOutlet weak var inspirationalFilmsGenres: UILabel!
    @IBOutlet weak var inspirationalFilmsRating: UILabel!
    
    @IBOutlet weak var inspirationalFilmsPlayButton: UIButton!
    @IBAction func inspirationalFilmsPlayButtonAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var inspirationalFilmsImagesButton: UIButton!
    @IBAction func inspirationalFilmsImagesButtonAction(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var inspirationalFilmsVideosButton: UIButton!
    @IBAction func inspirationalFilmsVideosButtonAction(_ sender: UIButton) {
        
    }
    @IBOutlet weak var inspirationalFilmsLoveButton: UIButton!
    @IBAction func inspirationalFilmsLoveButtonAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InspirationalFilmsViewController.updateInspirationalFilm
        .subscribe(onNext: { [weak self] (filmTitle) in
            guard let this = self else { return }
            this.setFilm(filmTitle)
        }).addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let film = inspirationalFilms.first {
            setFilmInfoLabel(film)
            setFilmScrollImages(film)
        }
        
    }
    
    func getCurrentFilm(_ title: String) -> InspirationalFilms? {
        return inspirationalFilms.filter{ $0.title == title }.first
    }
    
    func setFilm(_ title:String){
        if let film = getCurrentFilm(title) {
            setFilmInfoLabel(film)
            setFilmScrollImages(film)
        }
    }
    
    func setFilmInfoLabel(_ film: InspirationalFilms){
        inspirationalFilmsTitle.text = film.title
        inspirationalFilmsYear.text = "\(film.filmInfo.year)  "
        inspirationalFilmsGenres.text = "   |   " + film.filmInfo.genres
            .map { $0.rawValue }.joined(separator: ", ") 
        inspirationalFilmsRating.text = "   |   " + film.filmInfo.rating.rawValue
        
    }
    
    func setFilmScrollImages(_ film: InspirationalFilms){
        
        let _ = filmsImagesScrollView.subviews.filter({ $0 is UIImageView }).map({ $0.removeFromSuperview() })
        film.setFeatureImages()
        let images = film.featuredImages
        let imageViewBounds = UIScreen.main.bounds
        let numberOfImages = images.count
        
        //reset scrollView content size
        filmsImagesScrollView.contentSize = CGSize(width: imageViewBounds.size.width, height: filmsImagesScrollView.bounds.size.height)
        
        //set the page control numbers of pages
        filmsImagesPageControl.numberOfPages = numberOfImages
        filmsImagesPageControl.currentPage = 0
        
        //build our slides
        for i in 0..<numberOfImages{
        
            let inspirationalFilmsImageView = UIImageView(frame: filmsImagesScrollView.bounds)
            inspirationalFilmsImageView.frame.origin.x = CGFloat(i) * imageViewBounds.size.width
            
            if let image = images[i] {
                inspirationalFilmsImageView.image = image
            }else{
                inspirationalFilmsImageView.image = UIImage(named: "noImage") ?? UIImage() 
            }
            inspirationalFilmsImageView.backgroundColor = UIColor.clear
            inspirationalFilmsImageView.contentMode = .scaleAspectFit
            filmsImagesScrollView.addSubview(inspirationalFilmsImageView)
        }
        
        //calculate the content width
        let contentWidth = imageViewBounds.size.width * CGFloat(numberOfImages)
        
        //set scrollView content size
        filmsImagesScrollView.contentSize = CGSize(width: contentWidth, height: filmsImagesScrollView.bounds.size.height)
        
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
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    struct FilmsStoryBoard{
        static let cellIdentifier = "Films Cell"
    }
    
    deinit {
        print("Inspirational view controller is \(#function)")
    }
    

}

// MARK: UISearchBarDelegate
extension InspirationalFilmsViewController : UISearchBarDelegate {
    
    
    /**
     * Called when the user click on the view (outside the SearchBar).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        
        //if touch.view != tableView
       // {
            self.searchBar.endEditing(true)
            //self.tableView.isHidden = true
       // }
        
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
       
        let text  = inspirationalFilms
            .filter( { $0.title.lowercased().contains( searchText.lowercased() )})
            .map{ $0.title }
        
        searchBarFiltered = text
        
        if(searchBarFiltered.count == 0){
            searchActive = false;
            //tableView.isHidden = true
        } else {
            //tableView.isHidden = false
            searchActive = true;
        }
        
        //self.tableView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension InspirationalFilmsViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirationalFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsStoryBoard.cellIdentifier, for: indexPath) as? InspirationalFilmsCollectionViewCell else {
            return InspirationalFilmsCollectionViewCell()
        }
        cell.inspirationalFilm = inspirationalFilms[indexPath.item]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension InspirationalFilmsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let itemWidth = screenWidth * 0.3
        let itemHeight = (collectionView.contentSize.height * 0.9) 
        
        return CGSize(width: itemWidth , height: itemHeight) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return contentInset
    }
}

// MARK: - UIScrollViewDelegate
extension InspirationalFilmsViewController : UIScrollViewDelegate{
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        
        if let scrol = (scrollView) as? InspirationalFilmsImagesScrollView {
            let currentPage = Int(scrol.contentOffset.x / UIScreen.main.bounds.size.width )
            filmsImagesPageControl.currentPage = currentPage
        }
        
    }
}



