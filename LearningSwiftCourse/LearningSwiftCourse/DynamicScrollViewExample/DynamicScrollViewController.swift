//
//  DynamicScrollViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

class DynamicScrollViewController: UIViewController {

    @IBAction func addItemAtIndexButton(_ sender: UIButton) {
        let index = addItemPickerView.selectedRow(inComponent: 0)
        addItemInTextScrollView(with: "hello", atIndex: index )
    }
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var fontTestLabel: UILabel!
    @IBOutlet weak var fontTestButton: UIButton!
    
    @IBOutlet weak var addItemPickerView: UIPickerView!
    @IBOutlet weak var textScrollView: UIScrollView!
    @IBOutlet weak var panelSrollView: UIScrollView!
    @IBOutlet weak var panelBookshelfButton: UIButton!
    @IBOutlet weak var panelStudentsButton: UIButton!
    @IBOutlet weak var panelPhonicsButton: UIButton!
    @IBOutlet weak var panelTweaksButton: UIButton!
    @IBOutlet weak var panelEmailButton: UIButton!
    @IBOutlet weak var panelLogoutButton: UIButton!
    @IBOutlet weak var panelGamesButton: UIButton!
    @IBOutlet weak var panelReadingButton: UIButton!
    
    @IBOutlet weak var panelBBCiPlayerLogoButton: UIButton!
    let selectedColor = UIColor.random
    var buttonsBackgroundView = [UIView]()
    
    var textScrollViewContentWidth : CGFloat = 0
    var textScrollViewElements = ["Students", "Book Shelf", "Phonics", "Settings", "BBC iPlayer Logo", "Feedback", "Logout", "Games", "Read👆"]
    var textScrollViewCurrentViews = [UIView]()
    let beginSpace : CGFloat = 8
    let outerSpacing : CGFloat = 5
    let innerSpacing : CGFloat = 20
    let backSpacing : CGFloat = 8
    let font = UIFont.systemFont(ofSize: 12)
    
    let disposable = DisposeBag()
        
    /* 
         Panel Scroll View
     */
    func getAllButtons() -> [UIButton]
    {
        return [ 
            panelBookshelfButton,
            panelStudentsButton,
            panelPhonicsButton,
            panelTweaksButton,
            panelBBCiPlayerLogoButton,
            panelEmailButton,
            panelLogoutButton,
            panelGamesButton,
            panelReadingButton
        ]
    }
    
    func changeButtonColor(at index: Int, color: UIColor){
        if !buttonsBackgroundView.isEmpty && buttonsBackgroundView.count > index {
            clearButtonsBackgroundViewColor()
            buttonsBackgroundView[index].backgroundColor = color.withAlphaComponent(0.5)
        }
    }
    
    func clearButtonsBackgroundViewColor(){
        _ = buttonsBackgroundView.map{ $0.backgroundColor = .clear }
    }
    
    func setupScrollViewItems(_ shouldWrapInsideView: Bool){
        
        let buttons = getAllButtons()
        let buttonsTotalWidth = buttons.map{ $0.bounds.width }.reduce( 0, + )
        let remainingWidth = UIScreen.main.bounds.width - buttonsTotalWidth
        
        let shouldWrap = (remainingWidth > 2) ? shouldWrapInsideView : false
        
        let numberOfElements = buttons.count
        let scrollViewHeight : CGFloat = panelSrollView.bounds.height
        let beginSpace : CGFloat = shouldWrap ? 1 : 10
        let spacing : CGFloat = shouldWrap ? remainingWidth / CGFloat(numberOfElements) : 20
        let endingSpace : CGFloat = shouldWrap ? 1 : 10
        
        //calculate all the content width
        var contentWidth : CGFloat = beginSpace
        
        for i in 0..<numberOfElements {
            //let position : CGPoint = buttons[i].bounds.origin
            let size : CGSize = buttons[i].bounds.size //CGSize(width: 32, height: 30)
            let itemWidth : CGFloat = size.width
            let y = (scrollViewHeight - size.height) / 2
            let x = contentWidth//beginSpace + CGFloat(i) * (itemWidth + spacing)
            
            let buttonFrame = CGRect(origin: CGPoint(x:x, y: y), size: size)
            buttons[i].frame = buttonFrame
            
            contentWidth += (i != numberOfElements - 1) ? (itemWidth + spacing) : itemWidth
            
            ////adding background view
            let buttonBackgroundViewWidth = (itemWidth + spacing)
            let buttonBackgroundViewX = x - (spacing / 2)
            let buttonBackgroundView = UIView(frame: CGRect(x: buttonBackgroundViewX, y: 0, width: buttonBackgroundViewWidth, height: scrollViewHeight))
            buttonBackgroundView.backgroundColor = UIColor.clear
            panelSrollView.addSubview(buttonBackgroundView)
            panelSrollView.sendSubview(toBack: buttonBackgroundView)
            buttonsBackgroundView.append(buttonBackgroundView)
        }
        
        contentWidth += endingSpace
        
        //set scrollView content size
        panelSrollView.contentSize = CGSize(width: contentWidth, height: scrollViewHeight)
    
    }
    
    func getIndex(with button : UIButton) -> Int? {
        return getAllButtons().index(of: button)
    }
    
    func addBorder(to view: UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        view.layer.borderColor = UIColor.systemsBlueColor().cgColor
        view.layer.borderWidth = 2.0
    }
    
    /* 
     Text Scroll View 
    */
    func createLabel(with frame: CGRect, text: String, xPos: CGFloat, font : UIFont) -> UILabel
    {
        let label = UILabel(frame: frame)
        label.text = text
        label.frame.origin.x = xPos
        label.textAlignment = .center
        label.backgroundColor = UIColor.random
        label.font = font
        addBorder(to: label)
        return label
    }
    
    func createButton(with frame: CGRect, text: String, xPos: CGFloat, font : UIFont) -> UIButton
    {
        let button = UIButton(type: .system) 
        button.frame = frame
        button.setTitle(text, for: .normal)
        button.frame.origin.x = xPos
        button.setTitleColor( UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.random
        button.titleLabel?.font = font
        addBorder(to: button)
        return button
    }
    
    func setupButtonsActions() {
        _ = getAllButtons().map{ $0
            .rx
            .tapGesture()
            .subscribe( onNext: { sender in
                let button = sender.view as! UIButton
                if let index = self.getIndex(with: button) {
                    self.changeButtonColor(at: index, color: self.selectedColor)
                }
            }).addDisposableTo(disposable)
        }
        clearButtonsBackgroundViewColor()
        
    }
    
    func setupFontTest(){
        
        let text = "UIApplicationDelegate"
        
        let labelframe = fontTestLabel.frame
        let labelfont = text.getFontSize(inFrame: labelframe, desiredFontSize: 100, reduceBy: 1)
        fontTestLabel.font = UIFont.systemFont(ofSize: labelfont)
        fontTestLabel.text = text
        addBorder(to:fontTestLabel)
        
        let buttonframe = fontTestButton.frame
        let buttonfont = text.getFontSize(inFrame: buttonframe, desiredFontSize: 100, reduceBy: 1)
        fontTestButton.titleLabel?.font = UIFont.systemFont(ofSize: buttonfont)
        fontTestButton.setTitle(text, for: .normal)
        addBorder(to:fontTestButton)
        
    }
    
    func setuptextScrollView(){
        
        var elementwidth : CGFloat = 100
        let elementheight = textScrollView.frame.size.height
        let numberOfElements = textScrollViewElements.count
        
        textScrollViewContentWidth = beginSpace
        
        for i in 0..<numberOfElements {
            
            let text = textScrollViewElements[i] 
            
            elementwidth = text.getWidth(constrainedBy: elementheight, with: font)
            let elementwidthWithSpacing = (elementwidth + innerSpacing)
            let frame = CGRect(x: 0, y: 0, width: elementwidthWithSpacing, height: elementheight )
            
            let xPos = textScrollViewContentWidth//CGFloat(i) * (elementwidth + spacing)
            
            if i < 3{
                let label = createLabel(with: frame, text: text, xPos: xPos, font: font)
                textScrollView?.addSubview(label)
                textScrollViewCurrentViews.append(label)
                
                addBorder(to: label)
            }else {
                let button = createButton(with: frame, text: text, xPos: xPos, font: font)
                textScrollView?.addSubview(button)
                textScrollViewCurrentViews.append(button)
            }
            
            if (i >= numberOfElements - 1) {
                textScrollViewContentWidth += elementwidthWithSpacing 
            }else {
                textScrollViewContentWidth += (elementwidthWithSpacing + outerSpacing)
            }
        }
        
        textScrollViewContentWidth += backSpacing
        
        //set scrollView content size
        textScrollView.contentSize = CGSize(width: textScrollViewContentWidth, height: elementheight)
        
        addItemPickerView.reloadAllComponents()
    }
    
    func addItemInTextScrollView(with text: String, atIndex: Int){
        var elementwidth : CGFloat = 100
        let elementheight = textScrollView.frame.size.height
        let numberOfElements = textScrollViewElements.count
        
        elementwidth = text.getWidth(constrainedBy: elementheight, with: font)
        let elementwidthWithSpacing = (elementwidth + innerSpacing)
        let frame = CGRect(x: 0, y: 0, width: elementwidthWithSpacing, height: elementheight )
       
        //getting x position 
        let xPos : CGFloat
        if (atIndex >= numberOfElements - 1) {
            xPos = textScrollViewContentWidth - backSpacing + outerSpacing
        }else {
            let difference = numberOfElements - (atIndex )
            let newTexts = textScrollViewElements.dropLast(difference)
            
            if newTexts.isEmpty {
                xPos = beginSpace
            }else {
                let offset = newTexts.map{ text -> CGFloat in
                    let width = text.getWidth(constrainedBy: elementheight, with: font)
                    return (width + innerSpacing + outerSpacing)
                }.reduce(0, +)
                xPos = beginSpace + offset
            }
        }
    
        let button = createButton(with: frame, text: text, xPos: xPos, font: font)
        textScrollView?.addSubview(button)
        
        textScrollViewElements.insert(text, at: atIndex)
        
        textScrollViewContentWidth += (elementwidthWithSpacing + outerSpacing)
        
        //set scrollView content size
        textScrollView.contentSize = CGSize(width: textScrollViewContentWidth, height: elementheight)
        
        //move other buttons
        if (atIndex < (numberOfElements - 1) ) {
            for i in atIndex..<textScrollViewCurrentViews.count {
                textScrollViewCurrentViews[i].frame.origin.x += (elementwidthWithSpacing + outerSpacing)
            }
        }
        textScrollViewCurrentViews.insert(button, at: atIndex)
        
        addItemPickerView.reloadAllComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupScrollViewItems(true)
        setupButtonsActions()
        setuptextScrollView()
        setupFontTest()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("Dynamic Scroll View controller is \(#function)")
    }

}


extension DynamicScrollViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return textScrollViewElements.count 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let array = [0..<textScrollViewElements.count].flatMap{ $0 }
        return String(array[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
    }
    
}

extension DynamicScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}

