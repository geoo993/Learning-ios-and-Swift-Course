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


import UIKit
import LearningSwiftCourseExtensions
import RxSwift

class BBCiPlayerTableViewController: UIViewController {

    
    let mainSectionsItems : [(channel:String,title:String,description:String)] = [
        ("","My Channel","20 programmes"),
        ("BBC ONE","Broken","5 episodes"),
        ("COLLECTION","Drama Picks","12 programmes"), 
        ("TODAY'S","Most Popular","40 programmes"),
        ("COLLECTION","Documentary Picks","14 programmes"),
    ]
    
    //("BBC ONE","Doctor Who","10 programmes"), 
    //("BBC ONE","The Met: Policing London","5 episodes"), 
    //("BBC THREE","Can't Cope","Won't Cope"), 
    //("COLLECTION","Film Picks","6 programmes"), 
    //("COLLECTION","Comedy Picks","9 programmes"), 
    
    
    var mainMenuData : [[BBCiPlayerVideosItems]] = {
        return [
            //After My Channel
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None, videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After Most Popular
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After New Series
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            //After Comedy Picks
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")],
            
            
            //After Documentary Picks
            [BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1"),
             BBCiPlayerVideosItems(channel: .BBCOne,imageHeading: .None,  videoTitle: "China", summary: "Serie 1")]
        ]
    }()

    let img : [UIImage] = [#imageLiteral(resourceName: "autumnlandscape"),#imageLiteral(resourceName: "desert"),#imageLiteral(resourceName: "GoldenGateBridge"),#imageLiteral(resourceName: "happiness"),#imageLiteral(resourceName: "pexels")]
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = #imageLiteral(resourceName: "BBC_iPlayer_logo_white")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        navItem.titleView = imageView
        
        self.tableView.layoutSubviews()
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
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
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
      
        let tablevc = self.storyboard?.instantiateViewController(withIdentifier: "BBCiPlayerContentTableViewController") as! BBCiPlayerContentTableViewController
    
        tablevc.titleName = self.mainSectionsItems[button.tag].title
        //tablevc.navBar.topItem?.title = self.mainSectionsItems[button.tag].title
        
        //self.navigationController?.pushViewController(vc!, animated: true)
        self.present(tablevc, animated: true, completion: { 
            print("BBCiPlayerContentTableViewController presented")
        })
    }
    
    func addItemsInSectionHeader(with view : UIView, section : Int )  {
        
        let screen = UIScreen.main.bounds.size
        let topViewFrame = CGRect(x: 0, y: 0, width: screen.width, height: cellHeaderHeight * 0.65)
        let topHeaderImage = img[section]
        let topHeaderImageView = UIImageView(image: topHeaderImage)
        topHeaderImageView.backgroundColor = UIColor.clear
        topHeaderImageView.frame = topViewFrame
        view.addSubview(topHeaderImageView)
        
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
   
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "iplayerTableViewCell") as! BBCiPlayerTableViewCell 
        //let size: CGSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        //let height = size.height
        //return UITableViewAutomaticDimension
        
        let numberOfItemsInCell = mainMenuData[indexPath.section].count
        let inPairs = numberOfItemsInCell / 2
       
        return ( (cellHeight + cellSpacing) * CGFloat(inPairs) ) + (cellVerticalInsect * 2) - cellSpacing
    }
    
    /*
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
 */
    
}
