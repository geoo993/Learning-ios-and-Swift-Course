//
//  RedViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    @IBOutlet weak var charactersLabel: UILabel!
    
    @IBOutlet weak var wordsLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //downcasting and getting the data from the navigation controller's model:
        let navController = navigationController as! NavigationViewController
        charactersLabel.text = "\(navController.model.numLetters())"
        wordsLabel.text = "\(navController.model.numWords())"
        
        displayIndex(navController.model.index())
    }
    
    func displayIndex(_ index: [String:Int] ){
        var textViewIndexString:String = ""
        for word in index.keys {
            textViewIndexString += "\(word) : \(index[word]!)\n"
        }
        textView.text = textViewIndexString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Red View"
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

}
