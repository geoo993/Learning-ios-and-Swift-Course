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
import AVKit
import AVFoundation
import IBAnimatable

@IBDesignable
class InspirationalFilmsViewController: UIViewController {

    public static var updateInspirationalFilm = BehaviorSubject(value: "")
    var disposeBag = DisposeBag()
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Mark: - InspirationalFilms sorted
    var currentFilmIndex = 0
    
    var inspirationalFilms : [InspirationalFilms] = {
        return InspirationalFilms
            .sortedInspirationalFilms()
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
    
    //Mark: - Video Player
    var videoPlayer: AVPlayer?
    var videoPlayerLayer :  AVPlayerLayer?
    
    //Mark: - Colors
    var dashboardTextsColor = UIColor(hex: "white")
    var selectedColor = UIColor(hex: "White")
    var unselectedColor = UIColor(hex: "clear")
    
    
    //Mark: - @IBOutlets and @IBAction
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var homebutton: AnimatableButton!
    @IBAction func homebuttonAction(_ sender: Any) {
        
        dismiss(animated: true) { 
            print("Inspirational Films view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var filmsMediaScrollView: InspirationalFilmsMediaScrollView!
    @IBOutlet weak var filmsMediaPageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var filmsLabelsScrollView: InspirationalFilmsLabelsScrollView!
    @IBOutlet weak var inspirationalFilmsTitle: UILabel!
    @IBOutlet weak var inspirationalFilmsYear: UILabel!
    @IBOutlet weak var inspirationalFilmsGenres: UILabel!
    @IBOutlet weak var inspirationalFilmsRating: UILabel!
    
    var playSelected = false
    @IBOutlet weak var inspirationalFilmsPlayView: UIView!
    @IBOutlet weak var inspirationalFilmsPlayButton: AnimatableButton!
    
    var toggletoImageOrVideo = false
    var imagesSelected = false
    @IBOutlet weak var inspirationalFilmsImagesView: UIView!
    @IBOutlet weak var inspirationalFilmsImagesButton: AnimatableButton!
   
    var videosSelected = false
    @IBOutlet weak var inspirationalFilmsVideosView: UIView!
    @IBOutlet weak var inspirationalFilmsVideosButton: AnimatableButton!
   
    var loveSelected = false
    @IBOutlet weak var inspirationalFilmsLoveView: UIView!
    @IBOutlet weak var inspirationalFilmsLoveButton: AnimatableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpSearchbar()
        updateDashBoardText()
        
        InspirationalFilmsViewController.updateInspirationalFilm
        .subscribe(onNext: { [weak self] (filmTitle) in
            guard let this = self else { return }
            this.setFilm(filmTitle)
            
        }).addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setFilm(inspirationalFilms.first?.title)
    }
    
    func updateDashBoardText(){
        setUpSearchbar()
        homebutton.tintColor = dashboardTextsColor
        inspirationalFilmsTitle.textColor = dashboardTextsColor
        inspirationalFilmsYear.textColor = dashboardTextsColor
        inspirationalFilmsGenres.textColor = dashboardTextsColor
        inspirationalFilmsRating.textColor = dashboardTextsColor
        inspirationalFilmsPlayButton.tintColor = dashboardTextsColor
        inspirationalFilmsImagesButton.tintColor = dashboardTextsColor
        inspirationalFilmsVideosButton.tintColor = dashboardTextsColor 
        inspirationalFilmsLoveButton.tintColor = dashboardTextsColor
        
    }
    
    func setUpSearchbar(){
        
        //searchBar.backgroundColor = UIColor(hex: "Orange")
        let color = dashboardTextsColor.withAlphaComponent(0.5)
        searchBar.textField?.placeHolderColor = color
        searchBar.textField?.placeHolderMagnifyingGlassColor = color
        searchBar.textColor = dashboardTextsColor
    }
    
    func setFilm(_ title: String?){
        
        if let filmTitle = title, 
            let film = InspirationalFilms.getCurrentFilm(filmTitle, sorted: true), 
            let index = InspirationalFilms.getSelectedFilmIndex(film: film, sorted: true) {
            currentFilmIndex = index
            setFilmInfoLabel(film)
            setFilmScrollImages(film)
            updateCellsBorder()
            
            toggletoImageOrVideo = false
            setToggleToVideoOrImage(toggle: toggletoImageOrVideo)
            
        }else{
            print("Cannot access film")
        }
        
    }
    
    func updateCellsBorder() {
        if let visibleCells = (self.collectionView.visibleCells as? [InspirationalFilmsCollectionViewCell]) {
            for cell in visibleCells{
                let indexPath = self.collectionView.indexPath(for: cell) 
                let borderWidth : CGFloat = (currentFilmIndex == indexPath?.row) ? 2 : 0
                cell.inspirationalFilmsCoverImageButton.borderWidth = borderWidth
                cell.inspirationalFilmsCoverImageButton.borderColor = dashboardTextsColor
            }
        }
    }
    
    func setFilmInfoLabel(_ film: InspirationalFilms){
        inspirationalFilmsTitle.text = film.title
        inspirationalFilmsYear.text = "\(film.filmInfo.year)"
        inspirationalFilmsGenres.text = "   |   " + film.filmInfo.genres
            .map { $0.rawValue }.joined(separator: ", ") 
        inspirationalFilmsRating.text = "   |   " + film.filmInfo.rating.rawValue
        
    }
    
    func setFilmScrollImages(_ film: InspirationalFilms){
        for sv in filmsMediaScrollView.subviews { sv.removeFromSuperview() }
        let _ = filmsMediaScrollView.subviews.filter({ $0 is UIImageView }).map({ $0.removeFromSuperview() })
        
        film.setFeatureImages()
        let images = film.featuredImages
        let imageViewBounds = UIScreen.main.bounds
        let numberOfImages = images.count
        
        if numberOfImages > 0 {
            
            //reset scrollView content size
            filmsMediaScrollView.contentSize = CGSize(width: imageViewBounds.size.width, height: filmsMediaScrollView.bounds.size.height)
            
            //set the page control numbers of pages
            filmsMediaPageControl.numberOfPages = numberOfImages
            filmsMediaPageControl.currentPage = 0
            
            //build our slides
            for i in 0..<numberOfImages{
            
                let inspirationalFilmsImageView = UIImageView(frame: filmsMediaScrollView.bounds)
                inspirationalFilmsImageView.frame.origin.x = CGFloat(i) * imageViewBounds.size.width
                
                if let image = images[i] {
                    inspirationalFilmsImageView.image = image
                }else{
                    inspirationalFilmsImageView.image = UIImage(named: "noImage") ?? UIImage() 
                }
                inspirationalFilmsImageView.backgroundColor = UIColor.clear
                inspirationalFilmsImageView.contentMode = .scaleAspectFit
                filmsMediaScrollView.addSubview(inspirationalFilmsImageView)
            }
            
            //calculate the content width
            let contentWidth = imageViewBounds.size.width * CGFloat(numberOfImages)
            
            //set scrollView content size
            filmsMediaScrollView.contentSize = CGSize(width: contentWidth, height: filmsMediaScrollView.bounds.size.height)
            
            filmsLabelsScrollView.contentSize = CGSize(width: filmsLabelsScrollView.contentSize.width, height: 0)
            
            filmsMediaPageControl.isHidden =  (numberOfImages > 20 || numberOfImages <= 1) ? true : false
            
            stopVideoPlayer()
            clearMediaArea()
        }
    }
    
    func setFilmScrollVideos(_ film: InspirationalFilms){
        for sv in filmsMediaScrollView.subviews { sv.removeFromSuperview() }
        let _ = filmsMediaScrollView.subviews.filter({ $0 is UIImageView }).map({ $0.removeFromSuperview() })
        
        film.setFeatureVideos()
        
        let videos = film.featuredVideos
        let videoViewBounds = UIScreen.main.bounds
        let numberOfVideos = videos.count
        
        if numberOfVideos > 0{
            
            //reset scrollView content size
            filmsMediaScrollView.contentSize = CGSize(width: videoViewBounds.size.width, height: filmsMediaScrollView.bounds.size.height)
            
            //set the page control numbers of pages
            filmsMediaPageControl.numberOfPages = numberOfVideos
            filmsMediaPageControl.currentPage = 0
            
            
            //build our slides
            for i in 0..<numberOfVideos{
                
                let inspirationalFilmsVideoView = UIImageView(frame: filmsMediaScrollView.bounds)
                inspirationalFilmsVideoView.frame.origin.x = CGFloat(i) * videoViewBounds.size.width
                
                inspirationalFilmsVideoView.backgroundColor = UIColor.clear
                inspirationalFilmsVideoView.contentMode = .scaleAspectFit
                filmsMediaScrollView.addSubview(inspirationalFilmsVideoView)
                
            }
            
            //calculate the content width
            let contentWidth = videoViewBounds.size.width * CGFloat(numberOfVideos)
            
            //set scrollView content size
            filmsMediaScrollView.contentSize = CGSize(width: contentWidth, height: filmsMediaScrollView.bounds.size.height)
            
            filmsLabelsScrollView.contentSize = CGSize(width: filmsLabelsScrollView.contentSize.width, height: 0)
            
            filmsMediaPageControl.isHidden =  (numberOfVideos > 20 || numberOfVideos <= 1) ? true : false
            
            
        }
        
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
    
    func clearAll(){
        videoPlayer = nil
        videoPlayerLayer = nil
        for sv in view.subviews {
            sv.removeFromSuperview()
        }
        view.removeFromSuperview()
    }
    
    deinit {
        
        clearAll()
        // perform the deinitialization
        print("Inspirational view controller is \(#function)")
    }
    

}

// MARK: UISearchBarDelegate
extension InspirationalFilmsViewController : UISearchBarDelegate {
    
    
    /**
     * Called when the user click on the view (outside the SearchBar).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let _:UITouch = touches.first else
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
        let borderWidth : CGFloat = (currentFilmIndex == indexPath.row) ? 2 : 0
        cell.inspirationalFilmsCoverImageButton.borderWidth = borderWidth
        cell.inspirationalFilmsCoverImageButton.borderColor = dashboardTextsColor
        cell.inspirationalFilm = inspirationalFilms[indexPath.item]
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension InspirationalFilmsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { 
        
        let autoResize = CGFloat.overrideSizeF(size: 1.2)
        let itemWidth = screenWidth * 0.3
        let itemHeight = (collectionView.contentSize.height * autoResize) 
        
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
        
        if let scrol = (scrollView) as? InspirationalFilmsMediaScrollView {
            let currentPage = Int(scrol.contentOffset.x / UIScreen.main.bounds.size.width )
            filmsMediaPageControl.currentPage = currentPage
            
            stopVideoPlayer()
            
            let currentFilm = inspirationalFilms[currentFilmIndex]
            if currentFilm.maxVideos > 0 && toggletoImageOrVideo {
                let currentFilmVideo = currentFilm.featuredVideos[filmsMediaPageControl.currentPage]
                playVideo(videoURL: currentFilmVideo)
            }
        }
      
    }
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
         if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
        }
    }
     
}

//Mark: - Play Video extension
extension InspirationalFilmsViewController {
    
    func clearMediaArea() {
        
        for view in filmsMediaScrollView.subviews {
            view.layer.sublayers = nil
            
            if let count = view.layer.sublayers?.count, count > 0 { 
                for layer: CALayer in view.layer.sublayers! {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        let _ = videoPlayerLayer?.sublayers?.map({ $0.removeFromSuperlayer() })
        videoPlayerLayer?.removeFromSuperlayer()
        videoPlayerLayer = nil
        videoPlayer = nil
        
    }
    
    func playVideo(videoURL: String)
    {
        clearMediaArea()
        
        let videoView = filmsMediaScrollView.subviews[filmsMediaPageControl.currentPage]
        videoView.layer.zPosition = 0;
        
        if let url = URL(string: videoURL) {
        
            //let item = AVPlayerItem(url: url)
            //let player = AVPlayer(playerItem: item)
            
            videoPlayer = AVPlayer(url: url)
            videoPlayer?.actionAtItemEnd = .none
            //videoPlayer?.isMuted = true
            
            videoPlayerLayer =  AVPlayerLayer(player: videoPlayer)
            videoPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPlayerLayer?.zPosition = -1
            
            videoPlayerLayer?.frame = videoView.bounds
            videoPlayerLayer?.backgroundColor = UIColor.clear.cgColor
            videoPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            videoView.backgroundColor = UIColor.clear
            //self.videoView.layer.addSublayer(playerLayer!)
            videoView.layer.insertSublayer(videoPlayerLayer!, at: 0)
            
        }
        
    }
    
    func playVideoPlayer() {
        if (videoPlayer?.currentItem != nil) {
            videoPlayer?.play()
        }
    }
    
    func pauseVideoPlayer() {
        videoPlayer?.pause()
    }
    
    func stopVideoPlayer() {
        pauseVideoPlayer()
        rewindVideoPlayer()
        
        playSelected = false
        let color = playSelected ? selectedColor : unselectedColor
        let colorInverse = playSelected ? UIColor.blue : dashboardTextsColor 
        let img = playSelected ? UIImage(named:"stopicon2") : UIImage(named:"startplaying")
        UIView.animate(withDuration: 0.2) { 
            self.updatePlayButton(image: img!, color: color, colorInverse: colorInverse)
        }
    }
    
    func rewindVideoPlayer() {
        videoPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
    }
    
}

// MARK: - UIButton Actions
extension InspirationalFilmsViewController {
    
 
    func updatePlayButton(image: UIImage, color: UIColor, colorInverse: UIColor){
        self.inspirationalFilmsPlayButton.setImage(image, for: .normal)
        UIView.animate(withDuration: 0.2) { 
            self.inspirationalFilmsPlayView.backgroundColor = color
            self.inspirationalFilmsPlayButton.backgroundColor = color
            self.inspirationalFilmsPlayButton.tintColor = colorInverse
        }
    }
    func updateLoveButton(color: UIColor, colorInverse: UIColor){
        
        UIView.animate(withDuration: 0.2) { 
            self.inspirationalFilmsLoveView.backgroundColor = color
            self.inspirationalFilmsLoveButton.backgroundColor = color
            self.inspirationalFilmsLoveButton.tintColor = colorInverse
        }
    }
    
    func setToggleToVideoOrImage(toggle: Bool){
        
        let currentFilm = inspirationalFilms[currentFilmIndex]
        if toggle{//videos
            UIView.animate(withDuration: 0.2) { 
                self.inspirationalFilmsImagesView.backgroundColor = self.unselectedColor
                self.inspirationalFilmsImagesButton.backgroundColor = self.unselectedColor
                self.inspirationalFilmsImagesButton.tintColor = self.dashboardTextsColor
                
                self.inspirationalFilmsVideosView.backgroundColor = self.selectedColor.withAlphaComponent(0.4)
                self.inspirationalFilmsVideosButton.backgroundColor = self.selectedColor.withAlphaComponent(0.2) 
                self.inspirationalFilmsVideosButton.tintColor = UIColor.blue
                
            }
            
            if (videosSelected ){
                
                self.setFilmScrollVideos(currentFilm)
                
                if currentFilm.maxVideos > 0 { 
                    let currentFilmVideo = currentFilm.featuredVideos[filmsMediaPageControl.currentPage]
                    playVideo(videoURL: currentFilmVideo)
                }
                
                videosSelected = false
            }
            imagesSelected = true
            
        }else {//images
            
            playSelected = false
            let color = playSelected ? selectedColor : unselectedColor
            let colorInverse = playSelected ? UIColor.blue : dashboardTextsColor 
            let img = playSelected ? UIImage(named:"stopicon2") : UIImage(named:"startplaying")
            UIView.animate(withDuration: 0.2) { 
                self.updatePlayButton(image: img!, color: color, colorInverse: colorInverse)
                self.inspirationalFilmsImagesView.backgroundColor = self.selectedColor.withAlphaComponent(0.4)
                self.inspirationalFilmsImagesButton.backgroundColor = self.selectedColor.withAlphaComponent(0.2) 
                self.inspirationalFilmsImagesButton.tintColor = UIColor.blue
                
                self.inspirationalFilmsVideosView.backgroundColor = self.unselectedColor
                self.inspirationalFilmsVideosButton.backgroundColor = self.unselectedColor
                self.inspirationalFilmsVideosButton.tintColor = self.dashboardTextsColor
            }
            
            if (imagesSelected ){
                self.setFilmScrollImages(currentFilm)
                imagesSelected = false
            }
            videosSelected = true
        }
    }
    
    @IBAction func inspirationalFilmsImagesButtonAction(_ sender: AnimatableButton) {
        toggletoImageOrVideo = false
        setToggleToVideoOrImage(toggle: toggletoImageOrVideo)
    }
    
    @IBAction func inspirationalFilmsVideosButtonAction(_ sender: AnimatableButton) {
        toggletoImageOrVideo = true
        setToggleToVideoOrImage(toggle: toggletoImageOrVideo)
    }
    
    
    @IBAction func inspirationalFilmsPlayButtonActionTouchDown(_ sender: AnimatableButton) {
       
    }
    
    @IBAction func inspirationalFilmsPlayButtonActionTouchInside(_ sender: AnimatableButton) {
        
        
        if toggletoImageOrVideo {
            playSelected = !playSelected
            let color = playSelected ? selectedColor.withAlphaComponent(0.4) : unselectedColor
            let colorInverse = playSelected ? UIColor.blue : dashboardTextsColor 
            let img = playSelected ? UIImage(named:"stopicon2") : UIImage(named:"startplaying") 
            
            if playSelected {
                playVideoPlayer()
            }else{
                pauseVideoPlayer()
            }
            
            updatePlayButton(image: img!, color: color, colorInverse: colorInverse)
        }
    }
    
    @IBAction func inspirationalFilmsPlayButtonActionTouchOutside(_ sender: AnimatableButton) {
        
        if toggletoImageOrVideo {
            playSelected = !playSelected
            let color = playSelected ? selectedColor.withAlphaComponent(0.4) : unselectedColor
            let colorInverse = playSelected ? UIColor.blue : dashboardTextsColor
            let img = playSelected ? UIImage(named:"stopicon2") : UIImage(named:"startplaying")
            
            if playSelected {
                playVideoPlayer()
            }else{
                pauseVideoPlayer()
            }
            
            updatePlayButton(image: img!, color: color, colorInverse: colorInverse)
        }
    }
    
    
    @IBAction func inspirationalFilmsLoveButtonActionTouchDown(_ sender: AnimatableButton) {
        
    }
    
    @IBAction func inspirationalFilmsLoveButtonActionTouchInside(_ sender: AnimatableButton) {
       
        loveSelected = !loveSelected
        let color = loveSelected ? selectedColor.withAlphaComponent(0.4) : unselectedColor
        let colorInverse = loveSelected ? UIColor.red : dashboardTextsColor
        updateLoveButton(color: color, colorInverse: colorInverse)
    }
    
    @IBAction func inspirationalFilmsLoveButtonActionTouchOutside(_ sender: AnimatableButton) {
        
        loveSelected = !loveSelected      
        let color = loveSelected ? selectedColor.withAlphaComponent(0.4) : unselectedColor
        let colorInverse = loveSelected ? UIColor.red : dashboardTextsColor 
        updateLoveButton(color: color, colorInverse: colorInverse)
    }
   
    
}


