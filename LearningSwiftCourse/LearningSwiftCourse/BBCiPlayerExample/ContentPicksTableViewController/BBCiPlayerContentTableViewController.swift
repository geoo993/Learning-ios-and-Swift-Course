//
//  BBCiPlayerContentTableViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerContentTableViewController: UIViewController {

    @IBAction func stopButton(_ sender: UINavigationItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playontvButton(_ sender: UINavigationItem) {
        print("Play on tv")
    }
    
    @IBOutlet weak var navBar : UINavigationBar!
    @IBOutlet weak var tableView : UITableView!
    
    var titleName : String = ""
    
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.clearNavigationBarBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navBar.topItem?.title = titleName
        self.tableView.reloadData()
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UITableViewDataSource
extension BBCiPlayerContentTableViewController: UITableViewDataSource {
    
    // If user changes text, hide the tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableViewCell") as! BBCiPlayerContentTableViewCell
       
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, 
                                                            y: cell.frame.size.height - separatorHeight, 
                                                            width: screenSize.width, 
                                                            height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.gray
        cell.addSubview(additionalSeparator)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension BBCiPlayerContentTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}
