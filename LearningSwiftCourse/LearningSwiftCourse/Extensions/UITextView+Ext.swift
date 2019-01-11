//
//  UITextView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/27040924/nsrange-from-swift-range

import Foundation
import UIKit

public extension UITextView {
    
    public func textRangeToIntRange(range textRange: UITextRange) -> CountableRange<Int> {
        return self.range(from: textRange)
    }
    
    public func range(from textRange: UITextRange) -> CountableRange<Int> {
        let start = self.offset(from: self.beginningOfDocument, to: textRange.start)
        let end = self.offset(from: self.beginningOfDocument, to: textRange.end)
        return  start ..< end
    }
    
    public func clearTextView(with color: UIColor){
        let attribute = self.attributedText.mutableCopy() as! NSMutableAttributedString
        let fullrange = self.fullNSRange
        attribute.addAttributes([NSAttributedString.Key.foregroundColor: color], range: fullrange)
        self.attributedText = attribute
    }
    
    public var allNSRanges: [NSRange]
    {
        let textRange = self.text.startIndex..<self.text.endIndex
        var ranges = [NSRange]()
        self.text.enumerateSubstrings(in:textRange, options: NSString.EnumerationOptions.byWords, { (substring, substringRange, enclosingRange, stop) -> () in
            
            let range = NSRange(substringRange, in: self.text)
            ranges.append(range)
        })
        return ranges
    }
    
    public var fullNSRange: NSRange
    {
        let textRange = self.text.startIndex..<self.text.endIndex
        return NSRange(textRange, in: self.text)
    }
    
    public func nsRange(from range: Range<Int>) -> NSRange {
        return NSRange.init(location: range.lowerBound, length: range.upperBound)
        //return NSRange(range.lowerBound, range.upperBound)
    }
    
    public func rangeToIndex(from range: Range<Int>) -> Range<String.Index> {
        let startIndex = self.text.index(self.text.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.text.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
        return startIndex..<endIndex
    }
    
    public func rectForRange(range: Range<Int>) -> CGRect? {
        return self.rect(for: range)
    }
    
    public func rect(for range: CountableRange<Int>) -> CGRect? {
        guard let start   = self.position(from: self.beginningOfDocument, offset: range.lowerBound)
            , let end     = self.position(from: start, offset: range.count)
            , let textRange = self.textRange(from: start, to: end)
            else {
                return nil }
        let rect = self.firstRect(for: textRange)
        // TODO: Consider contentOffset for removal. (UITextView subviews don't need it.)
        //let offset = self.contentOffset
        return rect//.offsetBy(dx: -offset.x, dy: -offset.y)
    }
    
    // TODO: SWIFT4-2 Verify commenting the following `Invalid redeclaration of 'rect(fromRange:)'` is correct.
    //    public func rect(fromRange range: Range<Int>) -> CGRect? {
    //        guard
    //            let start = self.position(from: self.beginningOfDocument, offset: range.lowerBound),
    //            let end = self.position(from: self.beginningOfDocument, offset: range.upperBound),
    //            let textRange = self.textRange(from: start, to: end)
    //        else {
    //            return nil }
    //        let rect = firstRect(for: textRange)
    //
    //        // let offset = self.contentOffset
    //        return rect // .offsetBy(dx: -offset.x, dy: -offset.y)
    //    }
    
    public func numberOfLines() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSRange(location: 0, length: 1)
        var index = 0
        var numberOfLines = 0
        
        while (index < numberOfGlyphs) {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
    
}
