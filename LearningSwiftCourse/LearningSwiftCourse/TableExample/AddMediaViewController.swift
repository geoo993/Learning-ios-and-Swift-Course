//
//  AddingViewController.swift
//  TableViewDemo6
//
//  Created by Richard Campbell on 10/30/14.
//  Copyright (c) 2014 edumobile. All rights reserved.
//

import UIKit

protocol AddingDelegate {
    func newEntryAdded(newEntryTitle:String, newEntryImage: UIImage, newEntryDscription: String)
}

class AddMediaViewController: UIViewController, UITextViewDelegate {
    
    var delegate:AddingDelegate?
    
    @IBOutlet weak var imageviewNewItemImage: UIImageView!
    
    @IBOutlet weak var textviewNewItemDescriptionText: UITextView!
    
    @IBOutlet var textfieldNewItemTitle:UITextField!
    
    @IBAction func textfieldNewItemTitleDoneEditing(_ sender:UITextField) {
        //dismiss the keyboard:
        sender.resignFirstResponder()
        
        if let titleText = textfieldNewItemTitle.text {
        
            textviewNewItemDescriptionText.text = "New title called \(titleText)"
        }
        textviewNewItemDescriptionText.resignFirstResponder()
    }
    
    @IBOutlet var textfieldNewItemURL:UITextField!
    
    @IBAction func textfieldNewItemURLDoneEditing(_ sender:UITextField) {
        
        guard let urlString = sender.text, let url = URL(string: urlString) else { 
            print("No URL Found")
            return 
        }
        imageviewNewItemImage.downloadedFrom(url: url)
        
        //dismiss the keyboard:
        sender.resignFirstResponder()
        
        textviewNewItemDescriptionText.resignFirstResponder()
    }

    
    @IBOutlet weak var okayButtonObject: UIButton!
    
    @IBAction func okayButton(sender:UIButton) {
        guard 
        let titleText = textfieldNewItemTitle.text,
        let image = imageviewNewItemImage.image,
        let descriptionText = textviewNewItemDescriptionText.text 
        else {
            print("All fields are not completed");
            return
        }
        
        delegate?.newEntryAdded(newEntryTitle: titleText, newEntryImage: image, newEntryDscription: descriptionText)
        navigationController?.popViewController(animated: true) 
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        okayButtonObject.isEnabled = false
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        okayButtonObject.isEnabled = true
//        textView.resignFirstResponder()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textviewNewItemDescriptionText.delegate = self
        
        //remove this later
        textviewNewItemDescriptionText.isEditable = false
        textviewNewItemDescriptionText.isSelectable = false
        // Do any additional setup after loading the view.
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
