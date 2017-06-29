//
//  UIPickerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 29/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=-K9b87R8cvI
//https://www.youtube.com/watch?v=tGr7qsKGkzY

import UIKit

struct EmojiIcons {
    public enum Icons: String {
        case butterfly = "🦋" 
        case pullet = "🐥"
        case pig = "🐷"
        case lion = "🦁"
        case bear = "🐻"
        case panda = "🐼"
        case ladybird = "🐞"
        case unicorn = "🦄"
        case rabbit = "🐰"
        case monkey = "🐒"
        case octopus = "🐙"
        case penguin = "🐧"
    }
    
    public static let icons : [String : Icons] = 
    [ 
        "🦋" : .butterfly,
        "🐥" : .pullet,
        "🐷" : .pig,
        "🦁" : .lion,
        "🐻" : .bear,
        "🐼" : .panda,
        "🐞" : .ladybird,
        "🦄" : .unicorn,
        "🐰" : .rabbit,
        "🐒" : .monkey,
        "🐙" : .octopus,
        "🐧" : .penguin,
    ]
    
}

class UIPickerViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var emojiButton: UIButton!
 
    let pickerData = EmojiIcons.icons.map { $0.key }
    let numbersData = EmojiIcons.icons.map { $0.value }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension UIPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (component == 0) ? String(describing: numbersData[row]) : pickerData[row] 
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component ==  0 {
            pickerView.selectRow(row, inComponent: 1, animated: true)
        }
        if component ==  1 {
            pickerView.selectRow(row, inComponent: 0, animated: true)
        }
        emojiButton.setTitle(pickerData[row], for: .normal)
        
    }
    
}
