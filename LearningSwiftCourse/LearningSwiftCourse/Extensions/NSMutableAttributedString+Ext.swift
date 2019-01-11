
import Foundation

public extension NSMutableAttributedString {
    
    public func apply (with word: String) -> NSMutableAttributedString {
        let range = (self.string as NSString).range(of: word)
        return self.apply(with: word, range: range, last: range)
    }
    
    public func apply (with word: String, range: NSRange, last: NSRange) -> NSMutableAttributedString {
        if range.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
            let start = last.location + last.length
            let end = self.string.count - start
            let stringRange = NSRange(location: start, length: end)
            //print("string range = \(stringRange)")
            let newRange = (self.string as NSString).range(of: word, options: [], range: stringRange)
            _ = self.apply(with: word, range: newRange, last: range)
        }
        return self
    }
}
