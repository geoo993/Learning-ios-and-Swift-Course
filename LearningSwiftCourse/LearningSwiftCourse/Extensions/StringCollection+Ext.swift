extension Collection where Iterator.Element == String {
    public func getWords(withMinimumCharacterCount min: Int,
                         withMaximumCharacterCount max: Int) -> [String] {
        guard let words = self as? [String] else { return [] }
        return words.filter { ($0.count > min && $0.count < max) }
    }

    public func takeRandom(_ amount: Int, with minCharacterCount: Int) -> [String] {
        let words = filter({ $0.count >= minCharacterCount })
        return words.takeRandom(amount)
    }

    public func longestString(with font: UIFont) -> String? {
        return self.max(by: { ($1.count >= $0.count
            && $1.widthOfString(usingFont: font) > $0.widthOfString(usingFont: font)) })
    }

    public func removeRepeatedWords() -> [String] {
        guard let words = self as? [String] else { return [] }
        let wordsFrequency = words.elementOccurencesCount()
        return wordsFrequency
            .filter({ $0.value == 1 })
            .map({ $0.key })
    }
    
    public func removeDuplicatedString() -> [String] {
        guard let originalWords = self as? [String] else { return [] }
        let makeAllLowercased = originalWords.map { $0.lowercased() }
        return Array( Set(makeAllLowercased) )
    }
    
    public func removeFirstEmptySpace () -> [String] {
        return self.compactMap { sentence -> String in
            if (sentence.first == " ") {
                return String.replaceAt(str: sentence, index: 1, newCharac: "")
            } else {
                return sentence
            }
        }
    }

    ///remove Apostrophe words and its original word
    public func removeApostropheWords() -> [String] {
        guard let originalWords = self as? [String] else { return [] }
        
        var words = originalWords
        for (ind,word) in originalWords.enumerated() {
            if (originalWords.contains("\(word)\'s") ) {
                words.remove(at: ind)
                if let removeApostropheWordAtIndex = words.index(of: "\(word)\'s") {
                    words.remove(at: removeApostropheWordAtIndex)
                }
            }
        }
        
        return words
    }
    
    ///remove plural words and its original word
    public func removePluralWords(with minCharacterCount: Int) -> [String] {
        
        guard let originalWords = self as? [String] else { return [] }
        
        var wordsToRemove = [String]()
        for w in originalWords {
            if (originalWords.contains("\(w)s") && w.count > minCharacterCount) {
                wordsToRemove.append("\(w)s")
                wordsToRemove.append(w)
            }
        }
        return originalWords.filter { wordsToRemove.contains($0) == false }
        
    }
    
    public func removeHyphenatedWords() -> [String] {
        return self.compactMap { word -> String? in
            return ( word.contains("-") || word.contains("‐") || word.contains("‑") ) ? nil : word
        }
    }
    
}
