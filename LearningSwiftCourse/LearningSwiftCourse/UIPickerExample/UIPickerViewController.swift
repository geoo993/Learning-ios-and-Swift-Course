//
//  UIPickerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 29/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=-K9b87R8cvI
//https://www.youtube.com/watch?v=tGr7qsKGkzY
//https://www.youtube.com/watch?v=8EuoHAw_PBk

import UIKit
import LearningSwiftCourseExtensions
import AKPickerView
import class AKPickerView.AKPickerView

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
    
    @IBOutlet weak var verticalPicker: UIPickerView!
    @IBOutlet weak var horizontalPicker: UIPickerView!
    @IBOutlet weak var emojiButton: UIButton!
    var akpicker: AKPickerView!
 
    let pickerRowHeight : CGFloat = 50
    let pickerData = EmojiIcons.icons.map { $0.key }
    let numbersData = EmojiIcons.icons.map { $0.value }
    var rotationAngle : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupAKpicker()
        adjustHorizontalPicker()
        
    }
    
    
    func setupAKpicker() {
        // Do any additional setup after loading the view.
        let pickerFrame = CGRect(x: 0 , y: self.view.frame.size.height - 180, width: self.view.frame.size.width, height: 100)
        self.akpicker = AKPickerView(frame: pickerFrame)
        self.akpicker.delegate = self
        self.akpicker.dataSource = self
        
        self.view.addSubview(akpicker)
    }
    
    func adjustHorizontalPicker(){
        rotationAngle = -90 * (.pi / 180)
        let height : CGFloat = 100
        let y = UIScreen.main.bounds.size.height - height
        let width = UIScreen.main.bounds.size.width
        let pickerFrame = CGRect(x: 0, y: y, width: width, height: height)
        horizontalPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        horizontalPicker.frame = pickerFrame
    }
    
    func move(at position: Int ){
        verticalPicker.selectRow(position, inComponent: 0, animated: true)
        verticalPicker.selectRow(position, inComponent: 1, animated: true)
        horizontalPicker.selectRow(position, inComponent: 0, animated: true)
        akpicker.scrollToItem(position)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        akpicker.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let start = numbersData.count / 2
        move(at: start)
        
        
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
        
        if pickerView == horizontalPicker{
            return 1
        }
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == horizontalPicker{
            return pickerData[row]
        }
        
        return (component == 0) ? String(describing: numbersData[row]) : pickerData[row] 
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let rowSize = pickerView.rowSize(forComponent: component)
        
        if pickerView == horizontalPicker{
            let pickerViewItemFrame = CGRect(x: 0, y: 0, width: rowSize.height , height: rowSize.width )
            let text = pickerData[row] 
            let pickerViewItem = UIView.createPickerViewItem(with: pickerViewItemFrame, text: text)
            pickerViewItem.transform = CGAffineTransform(rotationAngle: (90 * (.pi / 180)) )
            return pickerViewItem
        }
        
        let text = (component == 0) ? String(describing: numbersData[row]) : pickerData[row] 
        let pickerViewItemFrame = CGRect(x: 0, y: 0, width: rowSize.width , height: rowSize.height )
        
        return UIView.createPickerViewItem(with: pickerViewItemFrame, text: text)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == horizontalPicker{
            emojiButton.setTitle(pickerData[row], for: .normal)
        }else {
        
            if component ==  0 {
                pickerView.selectRow(row, inComponent: 1, animated: true)
            }
            if component ==  1 {
                pickerView.selectRow(row, inComponent: 0, animated: true)
            }
            emojiButton.setTitle(pickerData[row], for: .normal)
        }
    }
    
}

extension UIPickerViewController: AKPickerViewDelegate, AKPickerViewDataSource {
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int
    {
        return pickerData.count 
    }
    
    @objc func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String
    {
        return pickerData[item]
    }
    
//    @objc func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage
//    {
//        
//    }
    
    @objc func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        emojiButton.setTitle(pickerData[item], for: .normal)
    }
    
}
