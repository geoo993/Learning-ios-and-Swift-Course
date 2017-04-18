//
//  CustomMediaViewController.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 15/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

class ChosenMediaDetailedViewController: UIViewController {

    @IBOutlet weak var detailedTitleTextView: UITextView!
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var detailedTextView: UITextView!
    
    
    var heading = String()
    var titleText = String()
    var descriptionText = String()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.randomColor()

        self.navigationItem.title = heading
    
        
        detailedTitleTextView.text = titleText
        detailedImageView.image = image
        detailedTextView.text = descriptionText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
