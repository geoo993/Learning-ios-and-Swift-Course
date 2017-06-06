//
//  IntroScreenViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 05/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController {

    let sectionInfo = ["Pages", "Games"]
    let pagesInfo = [
        [("Pages",20), ("Pages UnRead",6), ("Pages With ⭐️",8), ("Pages With ⭐️⭐️",4), ("Pages With ⭐️⭐️⭐️",2)],
        [("Missing Word 😀",129), ("Missing Words In A row",12), ("Swapped Words 😀",39),("Pairs 😀", 21), ("Wack A Mole 😀" , 50), ("Word Search 😀 " , 20)]
        ]
    
    let ommited = ["Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello",
                    "Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello",
                    "Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello"]
   
    //Mark: - Scroll view elements
    @IBOutlet weak var omittedWordsTitleLabel: UILabel!
    @IBOutlet weak var omittedWordsScrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        setFilmScrollVideos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*
        guard 
            let indexPath : IndexPath = self.tableView.indexPathForSelectedRow as IndexPath?,
            let tableViewController = segue.destination as? UITableViewController,//makeing sure that it is a UITableViewController
            let destinationViewController = tableViewController as? 
            ChosenMediaTableViewController
            else { 
                print("Cant Find Product Table View Controller or index path is wrong"); 
                return 
        }
        */
        
        
    }
    
    
    func setFilmScrollVideos(){
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
                omittedLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                omittedLabel.contentMode = .scaleAspectFit
                omittedWordsScrollView.addSubview(omittedLabel)
                
            }
            
            //calculate the content width
            let contentHeight = (height + spacing) * CGFloat(numberOfOmitted)
            
            //set scrollView content size
            omittedWordsScrollView.contentSize = CGSize(width: width, height: contentHeight)
            
            
        }
        
    }
    

}

// MARK: - Table view delegate
extension IntroScreenViewController:  UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagesInfo[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Intro Screen Cell", for: indexPath) as? IntroScreenTableViewCell
            else 
        { 
            print("No Cell found"); 
            return IntroScreenTableViewCell()
        }
        
        cell.titleLabel.text = pagesInfo[indexPath.section][indexPath.row].0
        cell.descriptionLabel.text = String(pagesInfo[indexPath.section][indexPath.row].1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

// MARK: - Table view data source
extension IntroScreenViewController: UITableViewDataSource {
    
    
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
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        
//        return "Footer"
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
    
  
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
extension IntroScreenViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
      
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
//        if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
//            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
//        }
    }
    
}










