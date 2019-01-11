//
//  NSAttributedString+Ext.swift
//  StoryCore
//
//  Created by GEORGE QUENTIN on 10/01/2018.
//  Copyright © 2018 LEXI LABS. All rights reserved.
//

extension NSUnderlineStyle {
    public static var none: NSUnderlineStyle {
        return NSUnderlineStyle.init(rawValue: 0)
    }
}

extension NSAttributedString {

    public func with(string: String) -> NSAttributedString? {
        let mutableAttributedText = self.mutableCopy()
        (mutableAttributedText as AnyObject).mutableString.setString(string)
        return mutableAttributedText as? NSAttributedString
    }
    
    public func color(words: [(NSRange, UIColor)], with style: NSUnderlineStyle?) -> NSMutableAttributedString {
        let stringStyle = style ?? NSUnderlineStyle.none
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: self)
        for (range, color) in words {
            attributedString.addAttributes([.foregroundColor: color, .underlineStyle: stringStyle.rawValue], range: range)
        }
        return attributedString
    }
    
    public func color(words: [(NSRange, UIColor)], with font: UIFont, style: NSUnderlineStyle?) -> NSMutableAttributedString {
        let stringStyle = style ?? NSUnderlineStyle.none
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: self)
        for (range, color) in words {
            attributedString.addAttributes([.foregroundColor: color,
                                            .font: font,
                                            .underlineStyle: stringStyle.rawValue],
                                           range: range)
        }
        return attributedString
    }
    
    public func clear(with color: UIColor, using clearFont: UIFont, thenColor words: [(NSRange, UIColor)],
                      with font: UIFont, style: NSUnderlineStyle?) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes([
            .foregroundColor: color,
            .font: clearFont,
            .underlineStyle: NSUnderlineStyle.none.rawValue
            ], range: NSRange(location: 0, length: self.length))
        
        let stringStyle = style ?? NSUnderlineStyle.none
        for (range, color) in words {
            attributedString.addAttributes([.foregroundColor: color,
                                            .font: font,
                                            .underlineStyle: stringStyle.rawValue],
                                           range: range)
        }
        return attributedString
    }
    
    public func highlight(toColor color: UIColor) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: length)
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes([
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.none.rawValue
            ], range: range)
        return attributedString
    }
    
    public func highlight(word range: NSRange, toColor color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes([
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.none.rawValue
            ], range: range)
        return attributedString
    }
    
    public func highlight(words ranges: [NSRange], toColor color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        for range in ranges {
            attributedString.addAttributes([
                .foregroundColor: color,
                .underlineStyle: NSUnderlineStyle.none.rawValue
                ], range: range)
        }
        return attributedString
    }
    
    public func underLine(toColor color: UIColor, style: NSUnderlineStyle) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: length)
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes([
            .foregroundColor: color,
            .underlineStyle: style.rawValue
            ], range: range)
        return attributedString
    }
    
    public func underLine(word range: NSRange, toColor color: UIColor,
                          style: NSUnderlineStyle) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes([
            .foregroundColor: color,
            .underlineStyle: style.rawValue
            ], range: range)
        return attributedString
    }
    
    public func underLine(words ranges: [NSRange], toColor color: UIColor,
                          style: NSUnderlineStyle) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        for range in ranges {
            attributedString.addAttributes([
                .foregroundColor: color,
                .underlineStyle: style.rawValue
                ], range: range)
        }
        return attributedString
    }
    
    public func strikeThroughLines(words ranges: [NSRange],
                                   toColor color: UIColor,
                                   style: NSUnderlineStyle) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        for range in ranges {
            attributedString.addAttributes([
                .foregroundColor: color,
                .strikethroughStyle: style.rawValue
                ], range: range)
        }
        return attributedString
    }
    
    public var attributes: [NSAttributedString.Key: Any] {
        guard length > 0 else { return [:] }
        return attributes(at: 0,
                          longestEffectiveRange: nil,
                          in: NSRange(location: 0, length: length))
    }
    
    public var font: UIFont {
        guard attributes.keys.contains(.font) else { return UIFont.systemFont(ofSize: 17) }
        return attributes[NSAttributedString.Key.font] as! UIFont
    }
    
    public var paragraphStyle: NSParagraphStyle? {
        guard attributes.keys.contains(.paragraphStyle) else { return nil }
        return attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle
    }
    
    public var lineHeight: CGFloat {
        guard let paragraphStyle = self.paragraphStyle else { return 0 }
        let lineHeight = font.lineHeight
        let lineHeightMultiple = paragraphStyle.lineHeightMultiple
        return lineHeight * ((lineHeightMultiple.isZero) ? 1 : lineHeightMultiple)
    }
    
    public var lineSpacing: CGFloat {
        return paragraphStyle?.lineSpacing ?? 0
    }
    
    public var lineBreakMode: NSLineBreakMode {
        return paragraphStyle?.lineBreakMode ?? .byWordWrapping
    }
    
    public var textAlignment: NSTextAlignment {
        return paragraphStyle?.alignment ?? NSTextAlignment.natural
    }
    
    public var backgroundColor: UIColor? {
        guard attributes.keys.contains(.backgroundColor) else { return nil }
        return attributes[NSAttributedString.Key.backgroundColor] as? UIColor
    }
    
    public var textColor: UIColor? {
        guard attributes.keys.contains(.foregroundColor) else { return nil }
        return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
    }
    
    public func font(at location: Int) -> UIFont? {
        if let font =
            self.attributes(at: location, effectiveRange: nil)[NSAttributedString.Key.font]
                as? UIFont {
            return font
        }
        return nil
    }
    
    public func lineHeight(at location: Int) -> CGFloat? {
        guard
            let paragraphStyle =
            self.attributes(at: location, effectiveRange: nil)[NSAttributedString.Key.paragraphStyle]
                as? NSParagraphStyle, let font = self.font(at: location) else {
                    return self.font.lineHeight
        }
        let lineHeightMultiple = paragraphStyle.lineHeightMultiple
        return font.lineHeight * ((lineHeightMultiple.isZero) ? 1 : lineHeightMultiple)
    }
    
    public func textAlignment(at location: Int) -> NSTextAlignment? {
        guard let paragraphStyle =
            self.attributes(at: location, effectiveRange: nil)[NSAttributedString.Key.paragraphStyle]
                as? NSParagraphStyle else {
                    return nil
        }
        return paragraphStyle.alignment
    }
    
    public func mutableAttributedString(from range: NSRange) -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: attributedSubstring(from: range))
    }
    
    public func boundingWidth(options: NSStringDrawingOptions, context: NSStringDrawingContext?) -> CGFloat {
        return boundingRect(options: options, context: context).size.width
    }
    
    public func boundingRect(options: NSStringDrawingOptions, context: NSStringDrawingContext?) -> CGRect {
        return boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude,
                                         height: CGFloat.greatestFiniteMagnitude),
                            options: options,
                            context: context)
    }
    
    public func boundingRectWithSize(with size: CGSize,
                                     options: NSStringDrawingOptions,
                                     numberOfLines: Int,
                                     context: NSStringDrawingContext?) -> CGRect {
        return boundingRect(with: CGSize(width: size.width,
                                         height: lineHeight * CGFloat(numberOfLines)),
                            options: options,
                            context: context)
    }

    public func createTextAttributes(with sentence: String,
                                     textColor: UIColor,
                                     textContainer: NSTextContainer,
                                     wordsToHighlight: [Range<Int>],
                                     wordsToHighlightColor: UIColor,
                                     numberOfLinesInText: Int,
                                     deviceUsedInDesigner: DeviceType) -> NSMutableAttributedString {

        let attributedText = self
        let attributedString = NSMutableAttributedString(string: sentence)

        // add paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        let lineSpacingFromDesigner = attributedText.lineSpacing

        let lineSpacing = CGFloat.recommenedHeight(withReferencedDevice: deviceUsedInDesigner,
                                                   desiredHeight: lineSpacingFromDesigner)
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = attributedText.paragraphStyle?.lineHeightMultiple ?? 0
        paragraphStyle.alignment = attributedText.textAlignment
        paragraphStyle.lineBreakMode = attributedText.lineBreakMode
        let paragraphStyleAttribute = [NSAttributedString.Key.paragraphStyle: paragraphStyle]

        // add text color
        let textColorAttribute = [
            NSAttributedString.Key.foregroundColor: textColor
        ]

        // add Background Color
        let backgroundColorAttribute = [
            NSAttributedString.Key.backgroundColor: attributedText.backgroundColor ?? .clear
        ]

        // Font
        let fonSize = CGFloat.recommenedWidth(withReferencedDevice: deviceUsedInDesigner,
                                              desiredWidth: attributedText.font.pointSize )
        let font = attributedText.font.withSize(fonSize)
        let fontAttribute = [NSAttributedString.Key.font: font]

        // Underline
        //let underLineAttribute: [NSAttributedStringKey: Any] =
        //    [  NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleThick.rawValue ]

        // Highlight
        let highlightAttribute: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: wordsToHighlightColor ]

        // add attributes
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes(paragraphStyleAttribute, range: range)
        attributedString.addAttributes(backgroundColorAttribute, range: range)
        attributedString.addAttributes(textColorAttribute, range: range)
        attributedString.addAttributes(fontAttribute, range: range)

        if wordsToHighlight.count > 0,
            let maxRange = wordsToHighlight.map({ $0.upperBound }).max() {
            for wordRange in wordsToHighlight where maxRange < attributedString.length {
                attributedString.addAttributes(highlightAttribute, range: wordRange.toNSRange)
            }
        }

        // changing font function works but the fact that we are using an exercise runner
        // that shrinks the size of the viewcontroller means that we have the incorrect size
        // of the textviewContainer and therefore getting the right font will not work
        return attributedString.getFont(frameSize: textContainer.size,
                                        numberOfLines: numberOfLinesInText,
                                        deviceUsedInDesigner: deviceUsedInDesigner)
    }


    public func getFont(frameSize: CGSize,
                        numberOfLines: Int,
                        deviceUsedInDesigner: DeviceType) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        var mutableAttributedString = attributedString
        let iteration = Int(attributedString.font.pointSize)
        let lineSpacingBasedOnDevice = CGFloat
            .recommenedHeight(withReferencedDevice: deviceUsedInDesigner,
                              desiredHeight: attributedString.lineSpacing)
        let lineSpacingTotal = lineSpacingBasedOnDevice * CGFloat(numberOfLines - 1)

        for i in 0 ..< iteration {
            let fontSize = CGFloat(iteration - i)
            let font = attributedString.font.withSize(fontSize)
            let textAttributedFont = [NSAttributedString.Key.font: font]
            let newMutable = mutableAttributedString
            let range = NSRange(location: 0, length: newMutable.length)
            newMutable.addAttributes(textAttributedFont, range: range)
            let textNSString: NSString = (newMutable.string as NSString)
            let lineHeight = newMutable.lineHeight
            let lineHeightBasedOnDevice = CGFloat
                .recommenedHeight(withReferencedDevice: deviceUsedInDesigner,
                                  desiredHeight: lineHeight)

            let lineHeightTotal = lineHeightBasedOnDevice * CGFloat(numberOfLines)
            let lineHeightWithSpacing = lineHeightTotal + lineSpacingTotal
            let size = textNSString.boundingRect(
                with: CGSize(width: frameSize.width, height: CGFloat.greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: textAttributedFont, context: nil).size
            let heightWithSpacing = size.height + lineSpacingTotal
            mutableAttributedString = newMutable
            if lineHeightWithSpacing > heightWithSpacing {
                break
            }
        }
        return mutableAttributedString
    }


}
