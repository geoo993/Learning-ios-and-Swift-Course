
public func * (lhs: Character, rhs: Int) -> String {
    return String(repeating: String(lhs), count: rhs)
}

public extension String {
    
    public func tokenizeToWord() -> [String] {
        return self.tokenize(option: kCFStringTokenizerUnitWord)
    }
    
    public func tokenizeToWordRemovingHyphenation() -> [String] {
        return self.filter { $0 != "-" }
            .tokenize(option: kCFStringTokenizerUnitWord)
    }
    
    public func tokenizeToWordRanges() -> [CountableRange<Int>] {
        return self.tokenizeRanges(option: kCFStringTokenizerUnitWord)
    }
    
    public func tokenizeToWordIndexRanges() -> [Range<String.Index>] {
        return self.tokenizeIndexRanges(option: kCFStringTokenizerUnitWord)
    }
    
    public func tokenizeToSentences() -> [String] {
        return self.tokenize(option: kCFStringTokenizerUnitSentence)
    }
    
    public func tokenizeToParagraphs() -> [String] {
        return self.tokenize(option: kCFStringTokenizerUnitParagraph)
    }
    
    public func tokenizeToLineBreaks() -> [String] {
        return self.tokenize(option: kCFStringTokenizerUnitLineBreak)
    }
    
    private func tokenize(option: CFOptionFlags) -> [String] {
        return self.tokenizeRanges(option: option).map { self.substring(with: $0) }
    }
    
    private func tokenizeRanges(option: CFOptionFlags) -> [CountableRange<Int>] {
        let inputRange = CFRangeMake(0, self.utf16.count)        
        let flag = UInt(option)
        let locale = CFLocaleCopyCurrent() 
        let cfString : CFString = self as CFString
        let tokenizer = CFStringTokenizerCreate( kCFAllocatorDefault, cfString, inputRange, flag, locale)
        var tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)        
        var tokenRanges : [CountableRange<Int>] = []
        let tokenTypeOptionSet : CFStringTokenizerTokenType = []
        while tokenType != tokenTypeOptionSet {
            let currentTokenRange = CFStringTokenizerGetCurrentTokenRange(tokenizer)
            let lower = Int(currentTokenRange.location)
            let upper = Int(currentTokenRange.location + currentTokenRange.length)
            let range = lower ..< upper 
            tokenRanges.append(range)            
            tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return tokenRanges
    }
    
    private func tokenizeIndexRanges(option: CFOptionFlags) -> [Range<String.Index>] {
        return tokenizeRanges(option: option).compactMap { self.range(fromCountableRange: $0) }
    }
    
    // Use linguistic tags to generate sentences from String
    public func toLinguisticTagRanges() -> (tags: [String], ranges: [Range<String.Index>]) {
        var r = [Range<String.Index>]()
        let i = self.indices
        let t = self.linguisticTags(
            in: i.startIndex ..< i.endIndex,
            scheme: NSLinguisticTagScheme.lexicalClass.rawValue,
            options: .joinNames,
            orthography: nil,
            tokenRanges: &r)
        
        return (t, r)
    }
    // Use linguistic tags to generate sentences from String
    public func toLinguisticWordRanges() -> (tags: [String], ranges: [Range<String.Index>]) {
        var r = [Range<String.Index>]()
        let i = self.indices
        let t = self.linguisticTags(
            in: i.startIndex ..< i.endIndex,
            scheme: NSLinguisticTagScheme.tokenType.rawValue,
            options: [.omitPunctuation, .omitWhitespace, .omitOther, .joinNames],
            orthography: nil,
            tokenRanges: &r)
        
        return (t, r)
    }
    
    private var regexSpecialCharactersBounderies: String {
        // https://regex101.com/
        return "[-'’%$#&/]\\b|\\b[‑'’%$#&/]|\\b[‐'’%$#&/]|\\d*\\.?\\d+|[A-Za-z0-9]|\\([A-Za-z0-9]"
    }
    
    private var regexWithSpecialCharactersWithinWords: String {
        // http://rubular.com/r/egE3v951RH
        return "(?<=\\s|^|\\b)(?:\(regexSpecialCharactersBounderies)+\\))+(?=\\s|$|\\b)"
    }
    
    private var regexWithCharactersAndPunctuations: String {
        // https://regex101.com/r/IpOqXy/17
        // https://stackoverflow.com/questions/42019240/regex-to-match-words-with-punctuation-but-not-punctuation-alone
        return "(?<=\\s|^|\\b)(?:\(regexSpecialCharactersBounderies)+\\))+(?=\\s|$|\\b)"
            + "|[^A-Za-z0-9\\s]"
    }
    
    public func toWordsFromRegexIncludingSpecialCharactersWithinWords() -> [String] {
        return self[regexWithSpecialCharactersWithinWords]
            .matches()
    }
    
    public func toRangesFromRegexIncludingSpecialCharactersWithinWords() -> [Range<Int>] {
        return self[regexWithSpecialCharactersWithinWords]
            .ranges()
            .map { $0.location ..< ($0.location + $0.length) }
    }
    
    public func toWordsFromRegexIncludingSpecialCharactersWithinWordsAndPunctuations() -> [String] {
        return self[regexWithCharactersAndPunctuations]
            .matches()
    }
    
    public func toNSRangesFromRegexIncludingSpecialCharactersWithinWordsAndPunctuations() -> [NSRange] {
        return self[regexWithCharactersAndPunctuations]
            .ranges()
    }
    
    public func toRangesFromRegexIncludingSpecialCharactersWithinWordsAndPunctuations() -> [Range<Int>] {
        return self[regexWithCharactersAndPunctuations]
            .ranges()
            .map { $0.location ..< ($0.location + $0.length) }
    }
    
    public func toWordsFromRegex() -> [String] {
        return self["(\\b[^\\s]+\\b)"].matches()
    }
    
    public func toWordNSRangesFromRegex() -> [NSRange] {
        return self["(\\b[^\\s]+\\b)"].ranges()
    }
    
    public func toWordRangesFromRegex() -> [Range<Int>] {
        return self["(\\b[^\\s]+\\b)"]
            .ranges()
            .map { $0.location ..< ($0.location + $0.length) }
    }

    public func toWords() -> [String] {
        let range = self.range(of: self)!
        var words = [String]()
        
        self.enumerateSubstrings(in: range, options: .byWords) { (substring, _, _, _) -> Void in
            words.append(substring!)
        }
        return words
    }
    
    public func toWordRanges() -> [Range<String.Index>] {
        
        let wordRange = self.range(of: self)!
        var ranges = [Range<String.Index>]()
        
        self.enumerateSubstrings(in: wordRange, options: .byWords) { (_, range, _, _) -> Void in
            ranges.append(range)
        }
        
        return ranges
    }
    
    public func toSentenceRanges() ->  [Range<String.Index>] {
        
        let charset = CharacterSet.whitespacesAndNewlines
        
        let (tags, textRanges) = 
            self.trimmingCharacters(in: charset)
                .toLinguisticTagsAndRanges()
        
        let sentenceSplit = 
            tags
                .enumerated()
                .split(omittingEmptySubsequences: true, 
                       whereSeparator: { 
                        return $0.element == "SentenceTerminator"
                })
                .map { $0.compactMap { $0 } }
        
        let sentenceRanges = 
            sentenceSplit
                .map { ($0.first?.offset ?? 0, $0.last?.offset ?? 0) }
                .map { first, last in textRanges[first].lowerBound ..< textRanges[last].upperBound }
        return sentenceRanges
    }
    
    public func toLinguisticSentences() -> [String] {
        let (tags, ranges) = toLinguisticTagsAndRanges()
        
        var result = [String]()
        let ixs = tags.enumerated().filter {
            $0.element == "SentenceTerminator"
            }
            .map { return ranges[$0.offset].lowerBound}
        
        if ixs.count == 0 {
            return [self]
        }
        var prev = self.startIndex
        for ix in ixs {
            let r = prev...ix
            let charset = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
            let trimmed = self[r].trimmingCharacters(in: charset)
            result.append(trimmed)
            prev = self.index(after: ix)
        }
        return result
    }
    
    public func toLinguisticTagsAndRanges() -> (tags: [String], ranges: [Range<String.Index>]) {
        var r = [Range<String.Index>]()
        let i = self.indices
        let t = self.linguisticTags(in: i.startIndex ..< i.endIndex, 
                                    scheme: NSLinguisticTagScheme.lexicalClass.rawValue, 
                                    options: NSLinguisticTagger.Options.joinNames, 
                                    orthography: nil, 
                                    tokenRanges: &r)
        return (t, r)
    }
    
    public func toLinguisticTagsWordsAndRanges() -> (tags: [String], words: [String], ranges: [NSRange]) {
        //www.hackingwithswift.com/example-code/strings/how-to-parse-a-sentence-using-nslinguistictagger
        let options = NSLinguisticTagger.Options.omitWhitespace.rawValue 
            | NSLinguisticTagger.Options.joinNames.rawValue
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger
            .availableTagSchemes(forLanguage: "en"), 
                                        options: Int(options))
        let inputString = self
        tagger.string = inputString
        var tags = [String]()
        var words = [String]()
        var ranges = [NSRange]()
        let range = NSRange(location: 0, length: inputString.utf16.count)
        tagger
            .enumerateTags(in: range, 
                           scheme: .nameTypeOrLexicalClass, 
                           options: NSLinguisticTagger
                            .Options(rawValue: options)) { (tag, tokenRange, _, _) in
                                guard let tag = tag?.rawValue, let range = Range(tokenRange, in: inputString) else { return }
                                let token = inputString[range]
                                let word = String(token)
                                //print("\(tag): \(token), \(tokenRange), \(sentenceRange)")
                                tags.append(tag)
                                words.append(word) 
                                ranges.append(tokenRange)
        }
        return (tags, words, ranges)
    }
    
    public func toLinguiticRangesWhilstResolvingHyphensAndParticles()
        -> [Range<Int>] {
            var ranges = [Range<Int>]()
            var foundDashOrParticle = 0
            let (tags, _, nsRanges) = toLinguisticTagsWordsAndRanges()
            _ = zip(tags, nsRanges)
                .map({ (tag, nsRange) in
                    let rangeInt = self.range(withNSRange: nsRange)
                    //print(tag, substring(withRange: rangeInt))
                    if (tag == "Dash" || tag == "Particle" || foundDashOrParticle == 1) {
                        if let lastRange = ranges.last, let index = ranges.index(of: lastRange) {
                            ranges[index] = lastRange.lowerBound..<rangeInt.upperBound
                            foundDashOrParticle = (foundDashOrParticle == 1 || tag == "Particle") 
                                ? 0 : foundDashOrParticle + 1
                        }
                    } else {
                        ranges.append(rangeInt)
                    }
                })
            return ranges
    }
    
    public func toLinguisticWordAndRange() -> [(word: String, range: Range<String.Index>)] {
        var wordRanges = [(String, Range<String.Index>)]()
        let nsString = NSString(string: self)
        let range = NSRange(location: 0, length: self.count)
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = self
        tagger.enumerateTags(
        in: range, scheme: .tokenType, options: .omitOther) { (tag, nsRange, _, _) in
            guard let tag = tag else { return }
            switch tag.rawValue {
            case "Word":
                let word = nsString.substring(with: nsRange)
                if let range = self.range(usingNSRange: nsRange) {
                    wordRanges.append((word, range))
                }
            default: break
            }
        }
        return wordRanges
    }

    public func indexAt(from: Int) -> String.Index {
        return self.index(startIndex, offsetBy: from)
    }

    public func character(atIndex index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    public func characterAsString(index: Int) -> String {
        return String(Array(self)[index])
    }
    
    public static func randomCharacter() -> Character {
        let characters = "ABCDEFGHIJKLKMNOPQRSTUVWXYZ"
        let len = UInt32(characters.count)
        let randomPosition = Int(arc4random_uniform(len))
        return characters[characters.index(characters.startIndex, offsetBy: randomPosition)]
    }

    private func substring(with range : CFRange) -> String {
        let nsrange = NSRange.init(location: range.location, length: range.length)
        let substring = (self as NSString).substring(with: nsrange)
        return substring
    }
    
    private func substring(with range : CountableRange<Int>) -> String {
        let nsrange = NSRange.init(location: range.lowerBound, length: range.count)
        let substring = (self as NSString).substring(with: nsrange)
        return substring
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(startIndex, offsetBy: value.lowerBound)...]
        }
    }
    
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex,offsetBy:index)
        return self[charIndex]
    }
    
    subscript(_ range: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let subString = self[start..<end]
        return String(subString)
    }
    
    subscript (range: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.count)
        return String(self[startIndex..<endIndex])
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = self.indexAt(from: from)
        return String(self[fromIndex...])
    }

    public func substring(to toIndex: Int) -> String {
        let index = self.indexAt(from: toIndex)
        return String(self[..<index]) // Swift 4
    }

    public func substring(from fromIndex: Int, to toIndex: Int) -> String {
        let start = index(startIndex, offsetBy: fromIndex)
        let end = index(start, offsetBy: toIndex - fromIndex)
        return String(self[start ..< end])
    }
    
    public func substring(withRange range: Range<Int>) -> String {
        let range = self.range(fromRangeInt: range)
        return String(self[range])
    }
    
    public func substring(withCountableRange range: CountableRange<Int>) -> String {
        let range = self.range(fromRangeInt: range.toRangeInt)
        return String(self[range])
    }
    
    public func substring(withNSRange range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    public func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    public func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    public func nsRange(fromStringIndex range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    public func nsRange(fromRangeInt rangeInt : Range<Int>) -> NSRange {
        return NSRange.init(location: rangeInt.lowerBound,
                         length: rangeInt.count)
    }
    
    public var nsRange: NSRange {
        return NSRange(location: 0, length: self.utf16.count)
    }
    
    public func range(usingNSRange nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    public func range(withNSRange nsRange : NSRange) -> Range<Int> {
        let start = nsRange.location
        let end = nsRange.location + nsRange.length
        return start..<end
    }
    
    public func range(fromStringIndex stringIndex: Range<String.Index>?) -> Range<Int> {
        guard let start = stringIndex?.lowerBound.encodedOffset,
            let end = stringIndex?.upperBound.encodedOffset else { return 0..<0 }
        return start..<end
    }

    public func range(fromRangeInt rangeInt: Range<Int>) -> Range<String.Index> {
        let startIndex = self.indexAt(from: rangeInt.lowerBound)
        let endIndex = self.indexAt(from: rangeInt.upperBound)
        return startIndex..<endIndex
    }

    public func range(fromRange range: Range<Int>) -> Range<String.Index> {
        let from = self.index(self.startIndex, offsetBy: range.lowerBound)
        let to = self.index(self.startIndex, offsetBy: range.upperBound)
        return from..<to
    }
    
    public func range(fromNSRange nsRange: NSRange) -> Range<String.Index> {
        let startIndex = indexAt(from: nsRange.location)
        let endIndex = indexAt(from: nsRange.location + nsRange.length)
        return startIndex..<endIndex
    }
    
    public func range(fromCountableRange countableRange: CountableRange<Int>) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(
                utf16.startIndex, 
                offsetBy: countableRange.lowerBound, 
                limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: countableRange.count, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    public func ranges(from string: String) -> [NSRange] {
        let wordRangesInt = self.toWordRangesFromRegex()
        var ranges:[NSRange] = []
        for range in wordRangesInt {
            let wordToHighlight = self.substring(withRange: range)
            
            if string == wordToHighlight {
                let stringIndexRange = self.range(fromRangeInt: range) 
                let nsRange = self.nsRange(fromStringIndex: stringIndexRange)
                ranges.append(nsRange)
            }
        }
        return ranges
    }
    
    public func range(ofUniqueWord word: String) -> NSRange? {
        let words = self
            .toWordsFromRegexIncludingSpecialCharactersWithinWords()
            .elementOccurencesCount()
        let ranges = self
            .toRangesFromRegexIncludingSpecialCharactersWithinWords()
        if let count = words[word],
            count < 2,
            let range = ranges.first(where: { self.substring(withRange: $0) == word }) {
            return range.toNSRange
        }
        return nil
    }
    
    public func ranges(ofWord word: String) -> [NSRange] {
        let words = self
            .toWordsFromRegexIncludingSpecialCharactersWithinWords()
            .elementOccurencesCount()
        let ranges = self
            .toRangesFromRegexIncludingSpecialCharactersWithinWords()
        if let count = words[word], count > 0 {
            return ranges
                .filter({ self.substring(withRange: $0) == word })
                .map({ $0.toNSRange })
        }
        return []
    }
    
    public func ranges(ofLinguisticTag type: [String]) -> [Range<String.Index>] {
        let (tags, ranges) = toLinguisticTagRanges()
        return zip(tags, ranges)
            .filter({ type.contains($0.0) })
            .map({ $0.1 })
    }
    
    // Correctly implement a shrink to fit on NSAttributedString
    public func getFontSize(fromFont: UIFont, inFrame: CGRect, desiredFontSize: Int, reduceBy: CGFloat) -> UIFont {
        let text = self
        var tempHeight : CGFloat = 0.0
        let labelSizeWidth = inFrame.size.width
        let labelSizeHeight = inFrame.size.height
        
        for i in 0..<desiredFontSize {
            
            let fontSize = CGFloat(desiredFontSize - i )
            let font = fromFont.withSize(fontSize)
            let textAttributedFont = [NSAttributedString.Key.font: font]
            let textNSString : NSString = (text as NSString)
            let size = textNSString.boundingRect(
                with: CGSize(width: labelSizeWidth, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: textAttributedFont, context: nil).size

            if (size.height < labelSizeHeight) {
                tempHeight = fontSize
                break
            }
        }
        return fromFont.withSize( tempHeight - reduceBy )
    }
    
    public func replaceHypthensWithNonBreakingHyphens() -> String {
        let nonBreakingHyphen = "\u{2011}"
        let hyphen = "\u{2010}"
        let hyphenMinus = "\u{002D}"
        let otherHyphens = [hyphen, hyphenMinus]
        return otherHyphens.reduce(self) { string ,hyphen  in
            return string.replacingOccurrences(of: hyphen, with: nonBreakingHyphen)
        }
    }
    
    public static func replaceAt(str: String, index: Int, newCharac: String) -> String {
        return str.substring(to: index - 1)  + newCharac + str.substring(from: index)
    }
    
    public func trimTrailingLeadingSpaces() -> String {
        return self["^\\s+|\\s+$|\\s+(?=\\s)"].replaceWith(template: "") as String
    }

    public func swapTwoUniqueWords(first: String, last: String) -> String {
        let words = self
            .toWordsFromRegexIncludingSpecialCharactersWithinWords()
            .elementOccurencesCount()
        if let firstWordCount = words[first], let secondWordCount = words[last],
            firstWordCount == 1, secondWordCount == 1 {
        
            let temp = "---79123923--"
            let change1 = self.replacingOccurrences(of: first, with: temp)
            let change2 = change1.replacingOccurrences(of: last, with: first)
            let change3 = change2.replacingOccurrences(of: temp, with: last)
            
            return change3
        }
        return self
    }

    public func highlight(wordsInRange ranges: [NSRange], toColor color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for range in ranges {
            attributedString.addAttributes([.foregroundColor: color], range: range)
        }
        return attributedString
    }
    
    func highlight(words: [String], toColor color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for word in words {
            let ranges = self.ranges(from: word)
            for range in ranges {
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
            }
        }
        return attributedString
    }
    
    public func getUniqueWords() -> [String] {
        let words = self.toWordsFromRegexIncludingSpecialCharactersWithinWords()
        return words.uniqueElements()
    }
    
    public func toWordsWhileRemovingRepeatedWords() -> [String] {
        return self
            .toWordsFromRegexIncludingSpecialCharactersWithinWords()
            .removeRepeatedWords()
    }
    
    public func getRepeatedWords() -> [String] {
        let words = self.toWordsFromRegexIncludingSpecialCharactersWithinWords()
        let wordsFrequency = words.elementOccurencesCount()
        return wordsFrequency
            .filter({ $0.value > 1 })
            .map({$0.key })
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constrainedSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constrainedSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return ceil(boundingBox.width)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let text: String = self
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let text: String = self
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: fontAttributes)
        return size.height
    }

    public func removeUnwantedCharacters(desiredSet: CharacterSet? = nil) -> String {
        let characterSet = desiredSet ?? CharacterSet.punctuationCharacters
        return self.components(separatedBy: characterSet).joined()
    }
    
    public func removeSpecialCharacters() -> String {
        return self[regexSpecialCharactersBounderies]
            .matches().joined()
    }
    
    //emoji 
    
    public func toUIImage(with fontSize: CGFloat) -> UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let im = image else {
            print("problem")
            return UIImage()
        }
        return im
    }
    
    public func toUIImage(with size: CGSize) -> UIImage {
        
        let baseSize = self.boundingRect(with: CGSize(width: 2048, height: 2048),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: UIFont.systemFont(ofSize: size.width / 2)],
                                         context: nil).size
        let fontSize = size.width / max(baseSize.width, baseSize.height) * (size.width / 2)
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = self.boundingRect(with: CGSize(width: size.width, height: size.height),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font],
                                         context: nil).size
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byClipping
        
        let attr : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : font,
                                                     NSAttributedString.Key.paragraphStyle: style,
                                                     NSAttributedString.Key.backgroundColor: UIColor.clear]
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        (self as NSString).draw(in: CGRect(x: (size.width - textSize.width) / 2,
                                           y: (size.height - textSize.height) / 2,
                                           width: textSize.width,
                                           height: textSize.height),
                                withAttributes: attr)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let img = image else { return UIImage() }
        return img
    }
    
    
    public func showEmojiDetail () -> String {
        return self.reduce("") { // loop through str individual characters
            var item = "\($1)" // string with the current char
            let isEmoji = item.containsEmoji // true or false
            
            if isEmoji {
                item = item.applyingTransform(StringTransform.toUnicodeName, reverse: false)!
            }
            return $0 + item
            }.replacingOccurrences(of:"\\N", with:"") // strips "\N"
        
    }
    /*
    public var containsEmoji: Bool {
        
        for scalar in self.unicodeScalars {
            switch scalar.value {
                
            case 0x2600...0x1F9FF:
                return true
            default:
                continue
            }
        }
        return false
    }
    */
    /// SwifterSwift: Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    public var containsEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    public func removeSpecialCharsFromString() -> String {
        let validCharacters = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        return String(self.filter { validCharacters.contains($0) })
    }
    
    public func removingEmoji () -> String {
        
        return self.reduce("") 
        { 
            let item = "\($1)" // string with the current char
            let isEmoji = item.containsEmoji // true or false
            
            if isEmoji {
                
                print("Found emoji", item)
                return ""
            }else {
                print("No emoji", item)
                return item
            }
        }
    }
    
    public static func getItemUrlFromBundle (bundleID: String, itemName:String, extention: String, subDirectory:String = "") -> URL? {
        guard let bundle = Bundle(identifier: bundleID) else { 
            print("Bundle ID is not valid")
            return nil 
        }
        let url = bundle.url(forResource: itemName, withExtension: extention, subdirectory: subDirectory)
        return url
    }
    
    public static func getItemPathFromBundle (bundleID: String, itemName:String, type: String, inDirectory:String = "") -> String? {
        guard let bundle = Bundle(identifier: bundleID) else { 
            print("Bundle ID is not valid")
            return nil 
        }
        let path = bundle.path(forResource: itemName, ofType: type, inDirectory: inDirectory)
        return path
    }
    
    // create a function for estimated string...
    public func estimatedStringFrame (with font :UIFont) -> CGRect {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 1000)
        
        let nsstring = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: self).boundingRect(with: size, options: nsstring, attributes: [NSAttributedString.Key.font : font], context: nil)
    }

    public func pad(_ width: Int) -> String {
        return padding(toLength: width, withPad: " ", startingAt: 0)
    }
    
    public static func timeString(time:TimeInterval) -> String {
        //let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        //return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    public func uniqueCharacter() -> Bool
    {
        var isUnique: Bool = true
        var sortedCharacters = self.sorted()
        for i in 0..<sortedCharacters.count {
            let character = sortedCharacters[i]
            sortedCharacters.remove(at: i)
            for y in 0..<sortedCharacters.count {
                let anotherCharacter = sortedCharacters[y]
                if character == anotherCharacter {
                    print(character)
                    print(anotherCharacter)
                    isUnique = false
                    return isUnique
                }
                else {
                    sortedCharacters.remove(at: i)
                }
            }
        }
        return isUnique
    }
    
    // https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/SwiftStdlib/StringExtensions.swift
    
    /// SwifterSwift: CamelCase of string.
    ///
    ///        "sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    public var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// SwifterSwift: Check if string contains one or more letters.
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains one or more numbers.
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains only letters.
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// SwifterSwift: Check if string contains at least one letter and one number.
    ///
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// SwifterSwift: Check if string is valid email format.
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".isValidEmail -> true
    ///
    public var isValidEmail: Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// SwifterSwift: Check if string is a valid URL.
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// SwifterSwift: Check if string is a valid schemed URL.
    ///
    ///        "https://google.com".isValidSchemedUrl -> true
    ///        "google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }
    
    /// SwifterSwift: Check if string is a valid https URL.
    ///
    ///        "https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }
    
    /// SwifterSwift: Check if string is a valid http URL.
    ///
    ///        "http://google.com".isValidHttpUrl -> true
    ///
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }
    
    /// SwifterSwift: Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    /// SwifterSwift: Check if string is a valid Swift number.
    ///
    /// Note:
    /// In North America, "." is the decimal separator,
    /// while in many parts of Europe "," is used,
    ///
    ///        "123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///        "abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    /// SwifterSwift: Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    public var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// SwifterSwift: Return each character in string as an Array.
    ///
    ///     "hello".toCharacters -> ["h", "e", "l", "l", "o"]
    ///
    public var toCharacters: [Character] {
        return Array(self)
    }
    
    /// SwifterSwift: Last character of string (if applicable).
    ///
    ///        "Hello".lastCharacterAsString -> Optional("o")
    ///        "".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = last else { return nil }
        return String(last)
    }
    
    /// SwifterSwift: Latinized string.
    ///
    ///        "Hèllö Wórld!".latinized -> "Hello World!"
    ///
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// SwifterSwift: Bool value from string (if applicable).
    ///
    ///        "1".bool -> true
    ///        "False".bool -> false
    ///        "Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd" formatted string.
    ///
    ///        "2007-06-29".date -> Optional(Date)
    ///
    public var date: Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    ///
    ///        "2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    public var dateTime: Date? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Lorem ipsum string of given length.
    ///
    /// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
    /// - Returns: Lorem ipsum dolor sit amet... string.
    public static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }
        
        // https://www.lipsum.com/
        let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        if loremIpsum.count > length {
            return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
        }
        return loremIpsum
    }
    
    /// SwifterSwift: URL from string (if applicable).
    ///
    ///        "https://google.com".url -> URL(string: "https://google.com")
    ///        "not url".toURL -> nil
    ///
    public var toURL: URL? {
        return URL(string: self)
    }
    
    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// SwifterSwift: URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// SwifterSwift: String without spaces and new lines.
    ///
    ///        "   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    public var removeSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// SwifterSwift: Check if the given string spelled correctly
    public var isSpelledCorrectly: Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: Locale.preferredLanguages.first ?? "en")
        return misspelledRange.location == NSNotFound
    }
}
