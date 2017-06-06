//
//  StorySmartiesViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class StorySmartiesViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        //let range = NSMakeRange(myTextView.text.characters.count - 1, 0)
        //myTextView.scrollRangeToVisible(range)
        
        myTextView.text = "Wilf had a cat. Seated around him were Biff, Chip, Kipper and Sally. A top hat was on the table. He held the cat in one hand and with the other placed a cloth. Chip looked at the hat with a smile. He was wearing a stripped jumper and beige trousers. Biff wore her hair in a pony-tail tied together with a yellow and red-spotted bow."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        
        print("Story Smarties view controller is \(#function)")
    }
    
}
