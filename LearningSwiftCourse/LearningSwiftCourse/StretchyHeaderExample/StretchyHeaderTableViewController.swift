//
//  StretchyHeaderTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//http://blog.matthewcheok.com/design-teardown-stretchy-headers/
//https://blog.frozenfirestudios.com/how-to-add-a-stretchy-flair-to-your-uicollectionview-e403822e0f33
//https://www.youtube.com/watch?v=lML5XMLrZEk
//https://www.youtube.com/watch?v=7pbU3BRqa7A

import UIKit

class StretchyHeaderRevealViewController: SWRevealViewController{
    
}


class StretchyHeaderTableViewController: UITableViewController {

    let items = [  
        NewStretchyHeaderItem(continent: .AsiaPacific, country: "China", summary: "Chinese dragons are legendary creatures in Chinese mythology, they are symbol of power, strength, and good luck. Even the Emperor of China used the dragon as a symbol of his imperial power and strength."),
        NewStretchyHeaderItem(continent: .Europe, country: "France", summary: "France is the most visited country in the world, with over 80 million visitors every year."),
        NewStretchyHeaderItem(continent: .MiddleEast, country: "Kuwait", summary: "Kuwait has the highest and most expensive currency in the world, 1 Kuwaiti Dinar is worth over 3 U.S. Dollars."),
        NewStretchyHeaderItem(continent: .Africa, country: "Nigeria", summary: "The Nigerian Cinema known as Nollywood is one of the biggest production of films in the world."),
        NewStretchyHeaderItem(continent: .AsiaPacific, country: "Japan",summary: "Ancient warriors of Japan were known as Samurai. They were highly skilled fighters and perhaps the most well known class of people in ancient Japan."),
        NewStretchyHeaderItem(continent: .Americas, country: "USA", summary: "The United States was the leading force behind the development of the Internet, it is home to the world's most popular social media companies."),
        NewStretchyHeaderItem(continent: .Europe, country: "Russia", summary: "Moscow has more billionaire residents than any other city in the world."),
        NewStretchyHeaderItem(continent: .Australia, country: "Australia", summary: "Australia is the only continent in the world with no active volcanos."),
        NewStretchyHeaderItem(continent: .Africa, country: "Madagascar", summary: "Madagascar has the third largest coral reef system in the world, the Toliara coral reef found off the south-western coast of Madagasca."),
        NewStretchyHeaderItem(continent: .Africa, country: "South Africa", summary: "South Africa is the only country in the world to have hosted the Football, Cricket and Rugby, World Cups."),
         NewStretchyHeaderItem(continent: .Americas, country: "Peru", summary: "The National University of San Marcos is the most important and respected higher-education institution in Peru, it is the oldest officially established university in the Americas founded in 1551."),
        NewStretchyHeaderItem(continent: .AsiaPacific, country: "India", summary: "Snake charming originated from India. It is practiced in India and other Asian nations."),
        NewStretchyHeaderItem(continent: .AsiaPacific, country: "Hong Kong", summary: "Hong Kong is the origin and home of the world's most famous Martial Artist, Bruce Lee."),
        NewStretchyHeaderItem(continent: .Europe, country: "Greece", summary: "Ancient Greece is said to have laid the foundation for Western civilization, it is said to have a major influence on the Roman Empire and European culture."),
        NewStretchyHeaderItem(continent: .Europe, country: "Germany", summary: "Some of the world's greatest Philosophers like Ludwig Feuerbach, Martin Heidegger, Karl Jaspers, Albert Schweitzer, Arthur Schopenhauer and Immanuel Kant were Germans."),
        NewStretchyHeaderItem(continent: .Americas, country: "Canada", summary: "Canada has the most educated population in the world, with over 50% of its population educated at the post secondary level."),
        NewStretchyHeaderItem(continent: .Africa, country: "Burundi", summary: "Burundi was or may still be home to the worlds most prolific man eating crocodile known as Gustave, he is rumored to have killed as many as 300 humans."),
        NewStretchyHeaderItem(continent: .Australia, country: "Australia", summary: "The world's largest reef system, the Great Barrier Reef is found in the Coral Sea, off the north-eastern coast of Australia."),
        NewStretchyHeaderItem(continent: .Americas, country: "Brazil", summary: "The largest part of the Amazon rainforest is located in Brazil."),
        NewStretchyHeaderItem(continent: .AsiaPacific, country: "Indonesia", summary: "Indonesia has the world’s longest snake called the Python Reticulates, which is 10 meters long and can be found on Sulawesi island"),
        NewStretchyHeaderItem(continent: .Africa, country: "Ethiopia", summary: "Ethiopia is the only country in Africa with its own alphabet. It consists of 209 symbols and 25 letter variants."),
        ]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var headerView: UIView! 
    
    let kTableHeaderHeight: CGFloat = 250.0  
    let kTableHeaderCutAway: CGFloat = 50.0  
    
    var useCutOff = true
    var headerCutOffLayer : CAShapeLayer!
    var slideShowView : SlideShowView? = nil
    let imageNames = ["autumnlandscape", "desert", "GoldenGateBridge", "happiness","japanvillage", "pexels", "treesfallredleaves", "bg-header"] 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }else{
            print("reveal is nil")
        }
        
        setupDate()
        
        setupHeaderView()
       
        updateHeaderView()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //setupSlideShow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //slideShowView?.animateImageViews()
    }
   
    func setupSlideShow(){
        headerImageView.image = UIImage()
        headerImageView.backgroundColor = UIColor.clear
        if slideShowView == nil {
            let headerFrame = headerView.frame
            let frame = CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height)
            let images = imageNames.flatMap{ UIImage(named: $0)! }
            slideShowView = SlideShowView(frame: frame, parentView: headerImageView, images: images) 
            headerImageView.addSubview(slideShowView!)
            headerImageView.bringSubview(toFront: slideShowView!)
        }
    }
    
    func setupDate(){
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        // "October 8, 2016"
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        headerDateLabel.text = formatter.string(from: currentDateTime)
    }
    
    
    func setupHeaderView(){
        //make table view header view nil, as we are replacing it with our own custom header view and adding it in table view
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        let effectiveHeight = useCutOff ? kTableHeaderHeight-kTableHeaderCutAway/2 : kTableHeaderHeight
        
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        if useCutOff {
            headerCutOffLayer = CAShapeLayer()
            headerCutOffLayer.fillColor = UIColor.black.cgColor
            
            headerView.layer.mask = headerCutOffLayer
        }
        
        headerImageView.image = UIImage(named: imageNames.chooseOne() )!
    }
    
    func updateHeaderView() {  
        
        let effectiveHeight = useCutOff ? kTableHeaderHeight-kTableHeaderCutAway/2 : kTableHeaderHeight
        
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            
            let effectiveOffsetheight = useCutOff ? -tableView.contentOffset.y + kTableHeaderCutAway/2 : -tableView.contentOffset.y
            
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = effectiveOffsetheight
        }
        
        headerView.frame = headerRect
    
        if useCutOff {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: headerRect.width, y: 0))
            path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
            path.addLine(to: CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
            headerCutOffLayer?.path = path.cgPath
        }
    }
    
    func clearAll(){
        slideShowView = nil
        headerView.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Stretchy header Menu  view controller is \(#function)")
    }
}

// Mark - Scroll View Datasource
extension StretchyHeaderTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        updateHeaderView()
    }
}    

    // MARK: - Table view data source
extension StretchyHeaderTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stretchyCell", for: indexPath)
        as! StretchyHeaderTableViewCell
        
        cell.newsItem = items[indexPath.row]
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */ 
    
}
    
    // MARK: - UITableViewDelegate
extension StretchyHeaderTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


}
