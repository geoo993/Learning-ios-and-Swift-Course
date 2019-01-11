//
//  RadialMenuTextViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//http://techqa.info/programming/question/25465274/get-tapped-word-from-uitextview-in-swift
//https://stackoverflow.com/questions/25465274/get-tapped-word-from-uitextview-in-swift
//https://stackoverflow.com/questions/25525171/uitextview-highlight-all-matches-using-swift
//https://stackoverflow.com/questions/40149122/how-to-change-color-of-text-stirngs-inside-uitextview-in-swift3
//https://stackoverflow.com/questions/38136587/swift-textview-identify-tapped-word-not-working

import UIKit

class RadialMenuTextViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var textView : UITextView!
    
    var radialMenu:RadialMenu!
    var showRadialMenu = false
    var firstPressLocation = CGPoint.zero
    
    let titleItems = ["hel","hell","hello","hellos","helloso","hellosol"]
    let menuRadius: CGFloat = 150.0
    let subMenuRadius: CGFloat = 20.0
    let colors = ["#C0392B", "#2ECC71", "#E67E22", "#3498DB", "#9B59B6", "#F1C40F",
                  "#16A085", "#8E44AD", "#2C3E50", "#F39C12", "#2980B9", "#27AE60",
                  "#D35400", "#34495E", "#E74C3C", "#1ABC9C"].map { UIColor(rgba: $0) }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTap()
        setupLongPress()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer is UITapGestureRecognizer || gestureRecognizer is UILongPressGestureRecognizer) {
            return true
        } else {
            return false
        }
    }
    
    
    func setupLongPress(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        longPress.numberOfTouchesRequired = 1
        longPress.numberOfTapsRequired = 0
        textView.addGestureRecognizer(longPress)
    }
    @objc func longPressed(_ gesture : UILongPressGestureRecognizer) {
        
        let location = gesture.location(in: textView)
        //let locationToSuperView = textView.convert(location, to: self.view)
        
        switch(gesture.state) {
        case .began:
            if showRadialMenu == false {
                wordSelected(at: location )
                setupRadialMenu(with: textView, titles: titleItems)
                firstPressLocation = location
                radialMenu.openAtPosition(firstPressLocation)
                
                showRadialMenu = true
            }
        case .changed:
            if showRadialMenu == true {
                radialMenu.moveAtPosition(location)
            }
        case .ended:
            
            if showRadialMenu == true {
                radialMenu.close()
                showRadialMenu = false
            }
        default:
            break
        }
        
    }
    
    func setupTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTextView))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        textView.addGestureRecognizer(tap)
    }
    @objc func tapTextView( _ sender : UITapGestureRecognizer) {
        
        var location = sender.location(in: textView)
        location.x -= textView.textContainerInset.left;
        location.y -= textView.textContainerInset.top;
        print()
        print("location: \(location)", textView.contentOffset)
        
        wordSelected(at: location )
    }
    
    public func wordSelected(at location: CGPoint)
    {
        let layoutManager = textView.layoutManager
        // character index at tap location
        let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if let tapPosition = textView.closestPosition(to:location),
            let textRange = textView.tokenizer
                .rangeEnclosingPosition(tapPosition, with: UITextGranularity.word, inDirection: /* UITextDirection.min */ UITextDirection.init(rawValue: 0)) {
            let wordRange = textView.range(from: textRange)
            
            let selectedWord = textView.text(in: textRange)
            let rect = textView.rect(for: wordRange)
            let rangeIndex = textView.rangeToIndex(from: wordRange.toRangeInt)
            let nsRange = NSRange(rangeIndex, in: textView.text)
            
            // if index is valid then do something.
            if characterIndex < textView.textStorage.length {
                
                // print the character index
                print("Your character is at index: \(characterIndex)") //optional character index.
                
                // print the character at the index
                let myRange = NSRange(location: characterIndex, length: 1)
                let substring = (textView.attributedText.string as NSString).substring(with: myRange)
                print("character at index: \(substring)")
                
                print("text range = \(textRange)")
                print("word range = \(wordRange)")
                print("ns range = \(nsRange)")
                print("range.location = \(nsRange.location)")
                print("range.length = \(nsRange.length)")
                print("selected word = \(selectedWord!)")
                print("selected word rect = \(rect!)")
                print("string Range = \(nsRange)")
                print("index Range \(rangeIndex)")
                let tappedPhrase = (textView.attributedText.string as NSString).substring(with: nsRange)
                print("tapped phrase: \(tappedPhrase)")
                
                //let newRange = (textView.attributedText.string as NSString).range(of: selectedWord!, options: [], range: nsRange)
                //print("new range = \(newRange)")
                
                //font
                let font = UIFont.systemFont(ofSize: 20)
                var attribute = NSMutableAttributedString(string: textView.text, attributes: [NSAttributedString.Key.font : font])
                //attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor : UIColor.red], range: nsRange)
                
                //color
                //let attribute = textView.attributedText.mutableCopy() as! NSMutableAttributedString
                attribute = attribute.apply( with: selectedWord!)
                //attribute.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: nsRange)
                textView.attributedText = attribute
                
            }
         
        } 
    }
 
    // MARK - RadialSubMenu 
    func setupRadialMenu(with superView: UIView, titles : [String]) {
        
        superView.removeSubview(with: RadialMenu.self)
        
        if radialMenu != nil {
            radialMenu = nil
        }
        
        // Setup radial menu
        var subMenus: [RadialSubMenu] = []
        for i in 0..<titles.count {
            let title = titles[i]
            subMenus.append( self.createSubMenuItem(i, image: nil, title: title, adjustWidth: true)  )
        }
        
        radialMenu = RadialMenu(menus: subMenus, radius: menuRadius)
        radialMenu.center = superView.center
        radialMenu.openDelayStep = 0.05
        radialMenu.closeDelayStep = 0.00
        radialMenu.minAngle = 180
        radialMenu.maxAngle = 360
        radialMenu.activatedDelay = 1.0
        radialMenu.backgroundView.alpha = 0.0
        radialMenu.onClose = {
            for subMenu in self.radialMenu.subMenus {
                self.resetSubMenu(subMenu)
            }
        }
        radialMenu.onHighlight = { subMenu in
            self.highlightSubMenu(subMenu)
            
            let color = self.colorForSubMenu(subMenu).withAlphaComponent(1.0)
            
            // TODO: Add nice color transition
            superView.backgroundColor = color
        }

        radialMenu.onUnhighlight = { subMenu in
            self.resetSubMenu(subMenu)
            superView.backgroundColor = UIColor.white
        }
        
        radialMenu.onClose = { 
            superView.backgroundColor = UIColor.white
        }
        
        radialMenu.onActivate = { subMenu in
            print ("activated menu \(subMenu.tag)")
        }
        
        superView.addSubview(radialMenu)
        //view.insertSubview(radialMenu, aboveSubview:textView)
        //view.addSubview(radialMenu)
        //view.bringSubview(toFront: radialMenu)
        //view.sendSubview(toBack: textView)
    }
    
    func createSubMenuItem(_ i: Int, image : UIImage?, title: String?, adjustWidth: Bool = false) -> RadialSubMenu {
        
        let dimension = CGFloat(subMenuRadius*2)
        let frame : CGRect
        let subMenu : RadialSubMenu
        
        if title != nil {
            //use button
            let textFont = UIFont.systemFont(ofSize: 14)
            let spacing : CGFloat = 20
            let extimatedWidth = title?.width(withConstraintedHeight: dimension, font: textFont)
            let width = adjustWidth ? (spacing + extimatedWidth!) : dimension
            frame = CGRect(x: 0.0, y: 0.0, width: width, height: dimension)
            let button = UIButton(frame: frame)
            button.setTitle(title, for: .normal)
            subMenu = RadialSubMenu(button: button)
        }else if title == nil && image != nil {
            //use image
            frame = CGRect(x: 0.0, y: 0.0, width: dimension, height: dimension)
            let imageV = UIImageView(image: image)
            imageV.frame = frame
            imageV.contentMode = .scaleAspectFit
            subMenu = RadialSubMenu(imageView: imageV)
        }else {
            frame = CGRect(x: 0.0, y: 0.0, width: dimension, height: dimension)
            subMenu = RadialSubMenu(frame: frame)
        }
        
        subMenu.isUserInteractionEnabled = true
        subMenu.layer.cornerRadius = subMenuRadius
        subMenu.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        subMenu.layer.borderWidth = 1
        subMenu.tag = i
        resetSubMenu(subMenu)
        
        return subMenu
    }
    
    func colorForSubMenu(_ subMenu: RadialSubMenu) -> UIColor {
        let pos = subMenu.tag % colors.count
        return colors[pos] as UIColor
    }
    
    func highlightSubMenu(_ subMenu: RadialSubMenu) {
        let color = colorForSubMenu(subMenu)
        subMenu.backgroundColor = color.withAlphaComponent(1.0)
    }
    
    func resetSubMenu(_ subMenu: RadialSubMenu) {
        let color = colorForSubMenu(subMenu)
        subMenu.backgroundColor = color.withAlphaComponent(0.75)
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
        print("Radial Menu Text View Controller \(#function)")
    }
    

}


extension RadialMenuTextViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        
    }
}
