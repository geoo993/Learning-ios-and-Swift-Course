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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTap()
        setupLongPress()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLongPress(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        longPress.numberOfTouchesRequired = 1
        longPress.numberOfTapsRequired = 0
        textView.addGestureRecognizer(longPress)
    }
    @objc func longPressed(_ sender : UILongPressGestureRecognizer) {
        print("long press")
    }
    
    func setupTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTextView))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        textView.addGestureRecognizer(tap)
    }
    
    @objc func tapTextView( _ sender : UITapGestureRecognizer) {
        
        //textView.clearTextView(with: UIColor.black )
        
        let layoutManager = textView.layoutManager
        var location = sender.location(in: textView)
        location.x -= textView.textContainerInset.left;
        location.y -= textView.textContainerInset.top;
        print()
        print("location: \(location)", textView.contentOffset)
        
        // character index at tap location
        let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if let tapPosition = textView.closestPosition(to:location),
            let textRange = textView.tokenizer.rangeEnclosingPosition(tapPosition, with: UITextGranularity.word, inDirection: UITextDirection.min) {
            let wordRange = textView.range(from: textRange)
            
            let selectedWord = textView.text(in: textRange)
            let rect = textView.rect(for: wordRange)
            let rangeIndex = textView.rangeToIndex(from: Range(wordRange))
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
                let attribute = NSMutableAttributedString(string: textView.text, attributes: [NSAttributedStringKey.font : font])
                //attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor : UIColor.red], range: nsRange)
                
                //color
                //let attribute = textView.attributedText.mutableCopy() as! NSMutableAttributedString
                //attribute = apply(string: attribute, word: selectedWord!)
                attribute.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: nsRange)
                textView.attributedText = attribute
                
            }
         
        } 
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer is UITapGestureRecognizer || gestureRecognizer is UILongPressGestureRecognizer) {
            return true
        } else {
            return false
        }
    }
    
    func apply (string: NSMutableAttributedString, word: String) -> NSMutableAttributedString {
        let range = (string.string as NSString).range(of: word)
        return apply(with: string, word: word, range: range, last: range)
    }
    
    func apply (with str: NSMutableAttributedString, word: String, range: NSRange, last: NSRange) -> NSMutableAttributedString {
        if range.location != NSNotFound {
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
            let start = last.location + last.length
            let end = str.string.characters.count - start
            let stringRange = NSRange(location: start, length: end)
            //print("string range = \(stringRange)")
            let newRange = (str.string as NSString).range(of: word, options: [], range: stringRange)
            apply(with: str, word: word, range: newRange, last: range)
        }
        return str
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
