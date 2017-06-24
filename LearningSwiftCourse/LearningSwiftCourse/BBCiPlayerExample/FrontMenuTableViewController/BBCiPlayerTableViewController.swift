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
    
    //slideshow
    //bbconeItems[5] 
    //bbccbeebiesItems[4]
    //bbcparliamentItems[2]
    //bbcfourItems[8]
    
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
        self.tableView.layoutSubviews()
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
        navBar = nil
        navItem = nil
        tableView = nil
    }
}

// MARK: - Table view data source and UITableViewDelegate
extension BBCiPlayerTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mainSectionsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        let sectionHeaderFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: cellHeaderHeight)
        let sectionHeader = UIView(frame: sectionHeaderFrame)
        
        sectionHeader.backgroundColor = UIColor.bbciplayerDark()
        addItemsInSectionHeader(with: sectionHeader, section: section)
        
        let sectionHeaderButton = UIButton(frame: sectionHeaderFrame)
        sectionHeaderButton.backgroundColor = UIColor.clear
        sectionHeaderButton.tag = section
        sectionHeaderButton.addTarget(self, action: #selector(self.sectionHeaderButtonAction(_:)), for: .touchUpInside)
        sectionHeader.addSubview(sectionHeaderButton)
        
        
        return sectionHeader
    }
    
    
    @objc func sectionHeaderButtonAction(_ button: UIButton) { 
      
//        let tablevc = self.storyboard?.instantiateViewController(withIdentifier: "BBCiPlayerContentTableViewController") as! BBCiPlayerContentTableViewController
//    
//        tablevc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        tablevc.titleName = self.mainSectionsItems[button.tag].title
//        
//        //self.navigationController?.pushViewController(vc!, animated: true)
//        self.present(tablevc, animated: true, completion: { 
//            print("BBCiPlayerContentTableViewController presented")
//        })
        
        let tablenavVc = self.storyboard?.instantiateViewController(withIdentifier: "BBCiPlayerContentNavigationController") as! BBCiPlayerContentNavigationController
        tablenavVc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        tablenavVc.titleName = self.mainSectionsItems[button.tag].title
        self.present(tablenavVc, animated: true, completion: { 
            print("BBCiPlayerContentNavigationController presented")
        })
        
    }
    
    func addItemsInSectionHeader(with view : UIView, section : Int )  {
        
        let screen = UIScreen.main.bounds.size
        let topViewFrame = CGRect(x: 0, y: 0, width: screen.width, height: cellHeaderHeight * 0.65)
        let topHeaderImage = mainSectionsItems[section].item.image
        let topHeaderImageView = UIImageView(image: topHeaderImage)
        topHeaderImageView.backgroundColor = UIColor.clear
        topHeaderImageView.frame = topViewFrame
        view.addSubview(topHeaderImageView)
        
        
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
        
        let bottomViewFrame = CGRect(x: 0, 
                                     y: topHeaderImageView.frame.size.height, 
                                     width: UIScreen.main.bounds.size.width, 
                                     height: cellHeaderHeight * 0.35 )
        let bottomView = UIView(frame: bottomViewFrame)
        bottomView.backgroundColor = UIColor.clear
        bottomView.frame = bottomViewFrame
        view.addSubview(bottomView)
        
        let bottomViewHeight = bottomView.frame.size.height
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
        return cellHeaderHeight // section 1 and above have 50 section height */
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
   
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfItemsInCell = mainMenuData[indexPath.section].count
        let inPairs : CGFloat = CGFloat(numberOfItemsInCell) / CGFloat(2.0)
        let inPairsRounded = inPairs.rounded(.toNearestOrAwayFromZero)
        
        return ( (cellHeight + cellSpacing) * inPairsRounded ) + (cellVerticalInsect * 2) - cellSpacing
    }

    
}
