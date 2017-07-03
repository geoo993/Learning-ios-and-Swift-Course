//
//  BBCiPlayerTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://contentpedlar.wordpress.com/2016/10/22/uicollectionview-in-uitableview/
//https://stackoverflow.com/questions/31582378/ios-8-swift-tableview-with-embedded-collectionview
//https://www.raywenderlich.com/129059/self-sizing-table-view-cells
//https://stackoverflow.com/questions/28600375/how-can-we-add-image-in-uitableview-section-header-using-swift
//https://stackoverflow.com/questions/1074006/is-it-possible-to-disable-floating-headers-in-uitableview-with-uitableviewstylep
//https://www.youtube.com/watch?v=k7_XFDXiGfU
//https://stackoverflow.com/questions/3521310/how-to-increase-the-uitableview-separator-height
//https://stackoverflow.com/questions/11236367/display-clearcolor-uiviewcontroller-over-uiviewcontroller


import UIKit
import LearningSwiftCourseExtensions
import RxSwift

class BBCiPlayerTableViewController: UIViewController {
    
    ////  * HEADER ITEMS  BEGIN  * ////
    @IBOutlet weak var headerTableView: BBCiPlayerStretchyTableView!
    
    // Full size of the drawer and also how much drawer is seen when open
    fileprivate var headerHeight :CGFloat = 354
    // How much is seen when closed (minimum 20 please)
    fileprivate var amountSeenWhenClosed : CGFloat = 62
    // How far the user has to drag to trigger the drawer to stay open or closed
    fileprivate var triggerPoint : CGFloat = 50
    //screen width
    fileprivate var screenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
    //screen height
    fileprivate var screenHeight : CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    var latestContentOffset = CGPoint.zero
    var lastContentOffset = CGPoint.zero
    var lastContentOffsetWhenSpringEnabled = CGPoint.zero
    var animator : UIDynamicAnimator? = nil
    var containerBoundary : UICollisionBehavior!
    var snapBehavior : UISnapBehavior!
    var dynamicItemBehavior : UIDynamicItemBehavior!
    var gravityBehavior : UIGravityBehavior!
    var panGesture : UIPanGestureRecognizer!
    var isOpen : Bool = false
    var isClosing : Bool = false
    ////  * HEADER ITEMS  END * ////
    
    
    
    //("BBC ONE","Doctor Who","10 programmes"), 
    //("BBC ONE","The Met: Policing London","5 episodes"), 
    //("BBC THREE","Can't Cope","Won't Cope"), 
    //("COLLECTION","Film Picks","6 programmes"), 
    //("COLLECTION","Comedy Picks","9 programmes"), 
    let bbconeItems = BBCiPlayerVideosItems.bbcOneItems()
    let bbctwoItems = BBCiPlayerVideosItems.bbcTwoItems()
    let bbcthreeItems = BBCiPlayerVideosItems.bbcThreeItems()
    let bbcfourItems = BBCiPlayerVideosItems.bbcFourItems()
    let bbcradioItems = BBCiPlayerVideosItems.bbcRadioItems()
    let bbccbbcItems = BBCiPlayerVideosItems.bbcCbbcItems()
    let bbccbeebiesItems = BBCiPlayerVideosItems.bbcCbeebiesItems()
    let bbcnewsItems = BBCiPlayerVideosItems.bbcNewsItems()
    let bbcparliamentItems = BBCiPlayerVideosItems.bbcParliamentItems()
    let bbcalbaItems = BBCiPlayerVideosItems.bbcAlbaItems()
    let bbcs4cItems = BBCiPlayerVideosItems.bbcS4CItems()
    
    var mainSectionsItems = [(channel:String,title:String, description:String, item:BBCiPlayerVideosItems)]()
    var mainMenuData = [[BBCiPlayerVideosItems]]()
    var firstHeaderViewSlideShowContainer : SlideShowView? = nil
    var firstHeaderViewSlideShowImages : [UIImage] = []
    
    var cellSpacing : CGFloat = 2
    var cellVerticalInsect : CGFloat = 4
    var cellHeight : CGFloat = CGFloat.overrideHeightSizeF(size: 260)
    var cellHeaderHeight = CGFloat.overrideHeightSizeF(size: 400)
    
    var disposable = DisposeBag()
    
    @IBOutlet weak var navBar : UINavigationBar!
    @IBOutlet weak var navItem : UINavigationItem!
    @IBOutlet weak var tableView : UITableView!
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.bbciplayerDark()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addBBCIplayerLogo()
        setupItems()

        initialHeaderSetup()
        
        tableView.layoutSubviews()
        
    }
    
    func addBBCIplayerLogo(){
        let image = #imageLiteral(resourceName: "BBC_iPlayer_logo_white")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        navItem.titleView = imageView
    }
    
    func setupItems() {
        
        mainSectionsItems = [
            ("","My Channel","20 programmes",bbconeItems[5]),
            ("TODAY'S","Most Popular","14 programmes",bbctwoItems[7]),
            ("BBC ONE","Broken","5 episodes",bbconeItems[3]),
            ("COLLECTION","Drama Picks","8 programmes", bbctwoItems[1]), 
            ("COLLECTION","Documentary Picks","3 programmes",bbcnewsItems[5]),
        ]
        
        mainMenuData = [
            
            //After My Channel
            [bbcthreeItems[1],bbccbeebiesItems[3],bbconeItems[6],bbcfourItems[8], bbcnewsItems[2],bbcparliamentItems[4]],
            
            //After Most Popular
            [bbctwoItems[0],bbctwoItems[2],bbccbeebiesItems[2], bbccbbcItems[2]],
            
            //After New Series
            [bbcthreeItems[10],bbcradioItems[3],bbcalbaItems[2]],
            
            //After Drama Picks
            [bbcfourItems[5], bbconeItems[2],bbcthreeItems[2],bbccbbcItems[3], bbcnewsItems[1],bbcfourItems[1]],
            
            //After Documentary Picks
            [bbconeItems[6], bbcfourItems[7], bbccbbcItems[4], bbcnewsItems[6], bbccbeebiesItems[0], bbctwoItems[3]]
        ]
        
        firstHeaderViewSlideShowImages = [
            bbconeItems[5], 
            bbccbeebiesItems[4],
            bbcparliamentItems[2],
            bbcfourItems[8],
            bbcthreeItems[4],
        ].flatMap{ $0.image }
    }
    
//    func getTopAreaHeight() -> CGFloat
//    {
//        let app = UIApplication.shared
//        let topBarHeight = app.statusBarFrame.height +
//            (self.navigationController?.navigationBar.frame.height)!
//        
//        return topBarHeight
//    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */ 

    deinit {
        view.removeEverything()
        navBar = nil
        navItem = nil
        tableView = nil
        headerTableView = nil
        firstHeaderViewSlideShowContainer = nil
        print("BBC iplayer view controller is \(#function)")
    }
}

// MARK: - Table view data source and UITableViewDelegate
extension BBCiPlayerTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if tableView == headerTableView {
            return 0
        }
        
        return mainSectionsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == headerTableView {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == headerTableView {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "iplayerTableViewCell", for: indexPath)
            as! BBCiPlayerTableViewCell
        //cell.tag = indexPath.section
        cell.collectionData = mainMenuData[indexPath.section]
        //cell.collectionView.collectionViewLayout.invalidateLayout()
        cell.backgroundColor = UIColor.bbciplayerDark()
        cell.collectionViewCellHeight = cellHeight
        cell.cellLineSpacing = cellSpacing
        cell.cellVerticalInsect = cellVerticalInsect
        cell.setCollectionViewLayout()
        cell.collectionView.reloadData()
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == headerTableView {
            return nil
        }
        
        let sectionHeaderFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: cellHeaderHeight)
        let sectionHeader = UIView(frame: sectionHeaderFrame)
        
        sectionHeader.backgroundColor = UIColor.bbciplayerDark()
        addItemsInSectionHeader(with: sectionHeader, section: section)
        
        //add button above items
        let sectionHeaderButton = UIButton(frame: sectionHeaderFrame)
        sectionHeaderButton.backgroundColor = UIColor.clear
        sectionHeaderButton.tag = section
        sectionHeaderButton.addTarget(self, action: #selector(self.sectionHeaderButtonAction(_:)), for: .touchUpInside)
        sectionHeader.addSubview(sectionHeaderButton)
        
        return sectionHeader
    }
    
    
    @objc func sectionHeaderButtonAction(_ button: UIButton) { 
   
        let tablenavVc = self.storyboard?.instantiateViewController(withIdentifier: "BBCiPlayerContentNavigationController") as! BBCiPlayerContentNavigationController
        tablenavVc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        tablenavVc.titleName = self.mainSectionsItems[button.tag].title
        self.present(tablenavVc, animated: true, completion: { 
            print("BBCiPlayerContentNavigationController presented")
        })
        
    }
    
    func addItemsInSectionHeader(with view : UIView, section : Int )  {
        
        let screen = UIScreen.main.bounds.size
        let topViewHeight = cellHeaderHeight * 0.65
        let topViewFrame = CGRect(x: 0, y: 0, width: screen.width, height: topViewHeight)
        if section == 0 {
            
            firstHeaderViewSlideShowContainer?.removeEverything()
            firstHeaderViewSlideShowContainer = nil
            if firstHeaderViewSlideShowContainer == nil {
                firstHeaderViewSlideShowContainer = SlideShowView(frame: topViewFrame, parentView: view, images: firstHeaderViewSlideShowImages)
                firstHeaderViewSlideShowContainer?.moveToDistance = 30
                firstHeaderViewSlideShowContainer?.duration = 6
                view.addSubview(firstHeaderViewSlideShowContainer!)
                firstHeaderViewSlideShowContainer?.animateImageViews()
            }
            
        }else {
            let topHeaderImage = mainSectionsItems[section].item.image
            let topHeaderImageView = UIImageView(image: topHeaderImage)
            topHeaderImageView.backgroundColor = UIColor.clear
            topHeaderImageView.frame = topViewFrame
            view.addSubview(topHeaderImageView)
        }
        
        let captionLabel = UILabel(frame: 
            CGRect(x:0, 
                   y: 0, 
                   width: 60, 
                   height: 15 ))
        let captionText = mainSectionsItems[section].item.caption.rawValue
        captionLabel.text = captionText
        captionLabel.textColor = UIColor.white
        captionLabel.backgroundColor = (captionText == "") ? UIColor.clear : UIColor.bbciplayerPink()
        captionLabel.font = UIFont(name: FamilyName.helvetica.rawValue, size: 8)
        view.addSubview(captionLabel)
        
        let bottomViewHeight = cellHeaderHeight * 0.35
        let bottomViewFrame = CGRect(x: 0, 
                                     y: topViewHeight, 
                                     width: UIScreen.main.bounds.size.width, 
                                     height: bottomViewHeight )
        let bottomView = UIView(frame: bottomViewFrame)
        bottomView.backgroundColor = UIColor.clear
        bottomView.frame = bottomViewFrame
        view.addSubview(bottomView)
        
        let channelLabel = UILabel(frame: 
            CGRect(x: 5, y:0, 
                   width: screen.width - 10, 
                   height: bottomViewHeight * 0.3))
        channelLabel.text = mainSectionsItems[section].channel
        channelLabel.textColor = UIColor.bbciplayerWhiteGray()
        channelLabel.font = UIFont(name: FamilyName.arialHebrewLight.rawValue, size: 12)
        
        let contentTitleLabel = UILabel(frame: 
            CGRect(x:5, 
                   y: channelLabel.frame.size.height - 5, 
                   width: screen.width - 10, 
                   height: bottomViewHeight * 0.4 ))
        contentTitleLabel.text = mainSectionsItems[section].title
        contentTitleLabel.textColor = UIColor.white
        contentTitleLabel.numberOfLines = 2
        contentTitleLabel.font = UIFont(name: FamilyName.arialHebrewLight.rawValue, size: 18)
        
        let contentDescriptionLabel = UILabel(frame: 
            CGRect(x: 5, 
                   y: channelLabel.frame.height + contentTitleLabel.frame.size.height - 20,
                   width: screen.width - 10, 
                   height: bottomViewHeight * 0.3))
        contentDescriptionLabel.text = mainSectionsItems[section].description
        contentDescriptionLabel.textColor = UIColor.bbciplayerWhiteGray()
        contentDescriptionLabel.numberOfLines = 2
        contentDescriptionLabel.font = UIFont(name: FamilyName.arialHebrewLight.rawValue, size: 12)

        bottomView.addSubview(channelLabel)
        bottomView.addSubview(contentTitleLabel)
        bottomView.addSubview(contentDescriptionLabel)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == headerTableView {
            return 0
        }
        
        return cellHeaderHeight // section 1 and above have 50 section height */
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == headerTableView {
            return 0
        }
        return CGFloat.leastNormalMagnitude
    }
   
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == headerTableView {
            return 0
        }
        
        let numberOfItemsInCell = mainMenuData[indexPath.section].count
        let inPairs : CGFloat = CGFloat(numberOfItemsInCell) / CGFloat(2.0)
        let inPairsRounded = inPairs.rounded(.toNearestOrAwayFromZero)
        
        return ( (cellHeight + cellSpacing) * inPairsRounded ) + (cellVerticalInsect * 2) - cellSpacing
    }

    
}


// Mark - Behaviours
extension BBCiPlayerTableViewController: UIGestureRecognizerDelegate  {
    
    
    func initialHeaderSetup(){
        setHeaderTableView()
        setupHeaderPanGesture()
        setupHeaderAnimator()
        shouldOpenPanelHeader(false)
    }
    
    func activateDrag(with drag : Bool) {
        headerTableView.isScrollEnabled = drag
        //headerTableView.isSpringLoaded = drag
    }
    
    func setHeaderTableView (){
        view.addSubview(headerTableView)
        let tableViewFrame = CGRect(origin: headerTableView.frame.origin, size: CGSize(width: screenWidth, height: headerHeight))
        headerTableView.frame = tableViewFrame
        headerTableView.tableViewShouldOpenPanel = {
            self.shouldOpenPanelHeader(true)
        }
        headerTableView.tableViewDissmissViewController = {
            self.dismiss(animated: true) {
                print("view controller dismissed, now going to home page")
            }
        }
    }
    
    func setupHeaderAnimator(){
        animator = UIDynamicAnimator(referenceView: view)
        animator?.delegate = self
        
        setupDynamicItemBehavior()
        setupGravityBehavior()
        setupContainerBoundary()
        configureContainerBoundary()
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(dynamicItemBehavior)
        animator?.addBehavior(containerBoundary)
        
    }
    
    func setupDynamicItemBehavior (){
        dynamicItemBehavior = UIDynamicItemBehavior(items: [headerTableView])
        dynamicItemBehavior.resistance = 0
        dynamicItemBehavior.elasticity = 0
        dynamicItemBehavior.allowsRotation = false
    }
    func setupGravityBehavior (){
        gravityBehavior = UIGravityBehavior(items: [headerTableView])
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -1)
    }
    func setupContainerBoundary (){
        containerBoundary = UICollisionBehavior(items: [headerTableView])
    }
    
    func configureContainerBoundary (){
        let upperContainerBoundary = (-headerHeight + amountSeenWhenClosed)
        containerBoundary.addBoundary(withIdentifier: ("upperBoundary" as NSCopying) , from: CGPoint(x:0,y:upperContainerBoundary), to: CGPoint(x:screenWidth,y:upperContainerBoundary))
        
        let lowerContainerBoundary = headerHeight + 20
        containerBoundary.addBoundary(withIdentifier: ("lowerBoundary" as NSCopying) , from: CGPoint(x:0,y:lowerContainerBoundary), to: CGPoint(x:screenWidth,y:lowerContainerBoundary))
        
    }
    
    func snapToTop(_ gravityY: CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -gravityY)
        //self.tableView.roundCorners([.topRight, .topLeft], radius: 10)
    }
    
    func snapToBottom(_ gravityY:CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: gravityY)
        //self.tableView.roundCorners([.topRight, .topLeft], radius: 0)
    }
    
    func shouldOpenPanelHeader(_ open:Bool)
    {
        if open {
            snapToBottom( 2.0)
            removePanGestures()
            activateDrag(with: open )
        }else{
            snapToTop( 2.0 )
        }
    }
    
    func removePanGestures(){
        // Clean up existing pan recognizers
        panGesture.isEnabled = false
        headerTableView.removeGestureRecognizer(panGesture)
        panGesture = nil
    }
    
    func setupHeaderPanGesture(){
        // Add slide to open or close
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture?.cancelsTouchesInView = false
        headerTableView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(pan: UIPanGestureRecognizer) {
        
        let velocity = pan.velocity(in: view).y
        var movement = headerTableView.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.04)
        
        switch pan.state {
        case .began:
            break
        case .changed:
            
            if (snapBehavior != nil) {
                animator?.removeBehavior(snapBehavior)
            }
            snapBehavior = UISnapBehavior(item: headerTableView, snapTo: CGPoint(x: movement.midX, y: movement.midY))
            animator?.addBehavior(snapBehavior)
            break
        case .ended:
            panGestureEnded()
            break
        default:
            break
        }
        
    }
    
    func panGestureEnded(){
        
        if (snapBehavior != nil) {
            animator?.removeBehavior(snapBehavior)
        }
        let velocity = dynamicItemBehavior.linearVelocity(for: headerTableView)
        
        let panOffset = panGesture.translation(in: headerTableView!)
        let panMovement: CGFloat = abs(panOffset.y)
        
        
        //if fabsf(Float(velocity.y)) > Float(triggerPoint) {
        if (panMovement > triggerPoint) {
            if velocity.y < 0 {
                shouldOpenPanelHeader(false)
            }else{
                shouldOpenPanelHeader(true)
            }
        }else{
            
            if headerTableView.frame.origin.y > (headerHeight / 2) {
                shouldOpenPanelHeader(true)
            }else{
                shouldOpenPanelHeader(false)
            }
            
        }
        
    }
    
}

// Mark - UIDynamicAnimatorDelegate
extension BBCiPlayerTableViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        isOpen = (headerTableView.frame.origin.y > 0 )
        isClosing = false
        headerTableView.contentOffset = CGPoint.zero
        activateDrag(with: isOpen )
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}


// Mark - TableView Scroll Delegate and Datasource
extension BBCiPlayerTableViewController {
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == headerTableView {
            
            if isOpen == false {
                scrollView.contentOffset = CGPoint.zero
            }
            
            if isOpen {
                
                let currentOffset = scrollView.contentOffset;
                if (currentOffset.y > lastContentOffsetWhenSpringEnabled.y && currentOffset.y < 0 && isClosing == false)
                {
                    // Upward
                    
                    //make sure offset is at zero
                    UIView.animate(withDuration: 0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.9,
                                   initialSpringVelocity: 0.6,
                                   options: .beginFromCurrentState,
                                   animations: { [weak self] () -> Void in
                                    guard let this = self else { return }
                                    scrollView.contentOffset = CGPoint.zero
                                    this.headerTableView.contentOffset = CGPoint.zero
                                    this.headerTableView.layoutIfNeeded()
                                    
                        }, completion: { (completed) -> Void in
                            scrollView.contentOffset = CGPoint.zero
                    })
                    
                    
                }else if isClosing {
                    //scrollView.contentOffset = latestContentOffset
                    //print(scrollView.contentOffset,latestContentOffset ,isOpen)
                }
                else
                {
                    // Downward
                    //print("heading downward")
                }
                
                lastContentOffsetWhenSpringEnabled = currentOffset;
            }
        
        }
    }
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == headerTableView {
            
            if isOpen {
                let panGestureRecognizer = scrollView.panGestureRecognizer
                let panOffset = panGestureRecognizer.translation(in: scrollView)
                let panMovement: CGFloat = abs(panOffset.y)
                
                lastContentOffset = CGPoint.zero
                let currentOffset = scrollView.contentOffset
                let goingUp = (currentOffset.y > lastContentOffset.y)
                lastContentOffset = currentOffset
                
                if (panMovement > triggerPoint && goingUp){
                    latestContentOffset = lastContentOffset
                    //activateDrag(with: false )
                    setupHeaderPanGesture()
                    shouldOpenPanelHeader(false)
                    isClosing = true
                }
                
            }
        
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == headerTableView {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
}

