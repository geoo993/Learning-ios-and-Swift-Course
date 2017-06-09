//
//  StorySmartiesViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//slide menu from:: https://www.youtube.com/watch?v=PyYrLy8kTYg
//https://www.youtube.com/watch?v=K1qrk6XOuIU&t=1350s
//https://www.youtube.com/watch?v=rafJcqqyS1E
//https://www.youtube.com/watch?v=oXRiwl7gf3I
//https://stackoverflow.com/questions/35221408/swift-move-uiview-on-slide-gesture

import UIKit


class StorySmartiesRevealViewController: SWRevealViewController{
    
}

class StorySmartiesViewController: UIViewController {
    
    ////Mark - main app outlets 
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func indexChanged(sender: UISegmentedControl) {
       
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("Read selected")
        case 1:
            print("Listen selected")
        case 2:
            
            dismiss(animated: true) { 
                print("view controller dismissed, now going to home page")
            }
        default:
            break; 
        }
    }
    
    ////Mark - setting view outlets 
    @IBOutlet weak var summaryView : SummaryView!
    @IBOutlet weak var omittedWordsTitleLabel: UILabel!
    @IBOutlet weak var omittedWordsScrollView: UIScrollView!
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    ////Mark - table view elements 
    let sectionInfo = ["Pages", "Games"]
    let pagesInfo = [
        [("Pages",20), ("Pages UnRead",6), ("Pages With ⭐️",8), ("Pages With ⭐️⭐️",4), ("Pages With ⭐️⭐️⭐️",2)],
        [("Missing Word 😀",129), ("Missing Words In A row",12), ("Swapped Words 😀",39),("Pairs 😀", 21), ("Wack A Mole 😀" , 50), ("Word Search 😀 " , 20)]
    ]
    
    let ommited = ["ommited","ommited","ommited","ommited","ommited","ommited",
                   "ommited","ommited","ommited","ommited","ommited",
                   "ommited","ommited","ommited","ommited","ommited",
                   "ommited","ommited","ommited","ommited","ommited","ommited",
                   "ommited","ommited","ommited","ommited","ommited",
                   "ommited","ommited","ommited","ommited","ommited","ommited"]
    
    func loadSettingsView(){
        self.view.addSubview(summaryView)
        
        let heightToSee : CGFloat = 60
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height * 0.925
        let frame = CGRect(x: 0, y: -height + heightToSee, width: width, height: height)
        
        summaryView.frame = frame
        summaryView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        summaryView.heightToSee = heightToSee
        summaryView.translatesAutoresizingMaskIntoConstraints = true
        summaryView.maxHeight = height
        summaryView.superViewHeight = self.view.bounds.size.height
        summaryView.setup()
        //summaryView.backImageView.blurImage()
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.randomColor()
      
        loadSettingsView()
        
        setupSWRevealViewController()
        
    }

    func setupSWRevealViewController (){
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 200
//            menuButton.target = revealViewController()
//            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }else{
            print("reveal is nil")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        setOmiitedWordScrollVideos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setOmiitedWordScrollVideos(){
        for sv in omittedWordsScrollView.subviews { sv.removeFromSuperview() }
        let _ = omittedWordsScrollView.subviews.filter({ $0 is UILabel }).map({ $0.removeFromSuperview() })
        
        let numberOfOmitted = ommited.count
        
        let width = omittedWordsTitleLabel.bounds.width
        let height : CGFloat = 30
        
        let firstSpace : CGFloat = 2 
        let spacing : CGFloat = 4
        
        
        if numberOfOmitted > 0{
            
            //reset scrollView content size
            omittedWordsScrollView.contentSize = CGSize(width: width, height: omittedWordsScrollView.bounds.size.height)
            
            //build our slides
            for i in 0..<numberOfOmitted{
                
                let yPos = firstSpace + CGFloat(i) * (height + spacing)
                let frame = CGRect(x: 0, y: yPos, width: width, height: height)
                
                let omittedLabel = UILabel(frame: frame)
                omittedWordsScrollView.frame.origin.y = CGFloat(i) * (height + spacing)
                
                omittedLabel.text = ommited[i]
                omittedLabel.textAlignment = .center
                omittedLabel.font = omittedLabel.font.withSize(15)
                omittedLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
                omittedLabel.contentMode = .scaleAspectFit
                omittedLabel.layer.cornerRadius = 5
                omittedLabel.clipsToBounds = true
                omittedWordsScrollView.addSubview(omittedLabel)
                
            }
            
            //calculate the content width
            let contentHeight = (height + spacing) * CGFloat(numberOfOmitted)
            
            //set scrollView content size
            omittedWordsScrollView.contentSize = CGSize(width: width, height: contentHeight)
            
            
        }
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  
    func clearAll(){
        myImageView = nil
        myTextView = nil
        segmentedControl = nil
        summaryView = nil
        omittedWordsTitleLabel = nil
        omittedWordsScrollView = nil
        panelView = nil
        tableView = nil
        
        if view != nil {
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            view.removeFromSuperview()
        }
    }
    
    
    deinit {
        clearAll()
        print("Story Smarties view controller is \(#function)")
    }
    
}


// MARK: - Table view delegate
extension StorySmartiesViewController:  UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagesInfo[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Summary View Cell", for: indexPath) 
            as? SummaryViewTableViewCell
            else 
        { 
            print("No Cell found"); 
            return SummaryViewTableViewCell()
        }
        
        cell.titleLabel.text = pagesInfo[indexPath.section][indexPath.row].0
        cell.descriptionLabel.text = String(pagesInfo[indexPath.section][indexPath.row].1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

// MARK: - Table view data source
extension StorySmartiesViewController: UITableViewDataSource {
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionInfo[section]
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //MediaLayers.mediaTypes.remove(at: indexPath.row)
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
}


// MARK: - UIScrollViewDelegate
extension StorySmartiesViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //        if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
        //            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
        //        }
    }
    
}


