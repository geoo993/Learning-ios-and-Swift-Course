//
//  String+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
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
        
        return NSString(string: self).boundingRect(with: size, options: nsstring, attributes: [NSAttributedStringKey.font : font], context: nil)
    }

    
    public func getFontSize(inFrame: CGRect, desiredFontSize : Int, reduceBy: CGFloat) -> CGFloat
    {
        let text = self
        var tempHeight : CGFloat = 0.0
        for i in 0..<desiredFontSize{
            
            let font = UIFont.systemFont(ofSize: CGFloat(i))
            let labelSizeWidth = inFrame.size.width
            let labelSizeHeight = inFrame.size.height
            let textAttributedFont = [NSAttributedStringKey.font: font]
            let textNSString : NSString = (text as NSString)
            let size = textNSString.boundingRect(with: CGSize(width: labelSizeWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textAttributedFont, context: nil).size
            
            let sizeHeight = size.height 
            if (sizeHeight > labelSizeHeight){
                tempHeight = CGFloat(i)
                break;
            }else{
                tempHeight = CGFloat(desiredFontSize)
            }
        }
        
        return tempHeight - reduceBy
        
        
    }
    
    public func getHeight(constrainedBy width: CGFloat, with font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    
    public func getWidth(constrainedBy height: CGFloat, with font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    
    //emoji 
    
    public func toUIImage(with fontSize: CGFloat) -> UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]) 
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let im = image else {
            print("problem")
            return UIImage()
        }
        return im
    }
    
    
    public func showEmojiDetail () -> String {
        return self.characters.reduce("") { // loop through str individual characters
            var item = "\($1)" // string with the current char
            let isEmoji = item.containsEmoji // true or false
            
            if isEmoji {
                item = item.applyingTransform(StringTransform.toUnicodeName, reverse: false)!
            }
            return $0 + item
            }.replacingOccurrences(of:"\\N", with:"") // strips "\N"
        
    }
    
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
    
    public func removeSpecialCharsFromString() -> String {
        let validCharacters = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(self.characters.filter { validCharacters.contains($0) })
    }
    
    public func removingEmoji () -> String {
        
        return self.characters.reduce("") 
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
    
    
}

public enum FamilyName: String {
    
    // Font Family: Copperplate
    case copperplateLight = "Copperplate-Light"
    case copperplate = "Copperplate"
    case copperplateBold = "Copperplate-Bold"
    
    // Font Family: Kohinoor Telugu
    case kohinoorTeluguRegular = "KohinoorTelugu-Regular"
    case kohinoorTeluguMedium = "KohinoorTelugu-Medium"
    case kohinoorTeluguLight = "KohinoorTelugu-Light"
    
    // Font Family: Thonburi
    case thonburi = "Thonburi"
    case thonburiBold = "Thonburi-Bold"
    case thonburiLight = "Thonburi-Light"
    
    // Font Family: Courier New
    case courierNewPSBoldMT = "CourierNewPS-BoldMT"
    case courierNewPSItalicMT = "CourierNewPS-ItalicMT"
    case courierNewPSMT = "CourierNewPSMT"
    case courierNewPSBoldItalicMT = "CourierNewPS-BoldItalicMT"
    
    // Font Family: Gill Sans
    case gillSansItalic = "GillSans-Italic"
    case gillSansBold = "GillSans-Bold"
    case gillSansBoldItalic = "GillSans-BoldItalic"
    case gillSansLightItalic = "GillSans-LightItalic"
    case gillSans = "GillSans"
    case gillSansLight = "GillSans-Light"
    case gillSansSemiBold = "GillSans-SemiBold"
    case gillSansSemiBoldItalic = "GillSans-SemiBoldItalic"
    case gillSansUltraBold = "GillSans-UltraBold"
    
    // Font Family: Apple SD Gothic Neo
    case appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    case appleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
    case appleSDGothicNeoThin = "AppleSDGothicNeo-Thin"
    case appleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    case appleSDGothicNeoLight = "AppleSDGothicNeo-Light"
    case appleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    case appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    
    // Font Family: Marker Felt
    case markerFeltThin = "MarkerFelt-Thin"
    case markerFeltWide = "MarkerFelt-Wide"
    
    // Font Family: Avenir Next Condensed
    case avenirNextCondensedBoldItalic = "AvenirNextCondensed-BoldItalic"
    case avenirNextCondensedHeavy = "AvenirNextCondensed-Heavy"
    case avenirNextCondensedMedium = "AvenirNextCondensed-Medium"
    case avenirNextCondensedRegular = "AvenirNextCondensed-Regular"
    case avenirNextCondensedHeavyItalic = "AvenirNextCondensed-HeavyItalic"
    case avenirNextCondensedMediumItalic = "AvenirNextCondensed-MediumItalic"
    case avenirNextCondensedItalic = "AvenirNextCondensed-Italic"
    case avenirNextCondensedUltraLightItalic = "AvenirNextCondensed-UltraLightItalic"
    case avenirNextCondensedUltraLight = "AvenirNextCondensed-UltraLight"
    case avenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
    case avenirNextCondensedBold = "AvenirNextCondensed-Bold"
    case avenirNextCondensedDemiBoldItalic = "AvenirNextCondensed-DemiBoldItalic"
    
    // Font Family: Tamil Sangam MN
    case tamilSangamMN = "TamilSangamMN"
    case tamilSangamMNBold = "TamilSangamMN-Bold"
    
    // Font Family: Helvetica Neue
    case helveticaNeueItalic = "HelveticaNeue-Italic"
    case helveticaNeueBold = "HelveticaNeue-Bold"
    case helveticaNeueUltraLight = "HelveticaNeue-UltraLight"
    case helveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
    case helveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
    case helveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
    case helveticaNeueMedium = "HelveticaNeue-Medium"
    case helveticaNeueLight = "HelveticaNeue-Light"
    case helveticaNeueThin = "HelveticaNeue-Thin"
    case helveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
    case helveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    case helveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
    case helveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    case helveticaNeue = "HelveticaNeue"
    
    // Font Family: Gurmukhi MN
    case gurmukhiMNBold = "GurmukhiMN-Bold"
    case gurmukhiMN = "GurmukhiMN"
    
    // Font Family: Times New Roman
    case timesNewRomanPSMT = "TimesNewRomanPSMT"
    case timesNewRomanPSBoldItalicMT = "TimesNewRomanPS-BoldItalicMT"
    case timesNewRomanPSItalicMT = "TimesNewRomanPS-ItalicMT"
    case timesNewRomanPSBoldMT = "TimesNewRomanPS-BoldMT"
    
    // Font Family: Georgia
    case georgiaBoldItalic = "Georgia-BoldItalic"
    case georgia = "Georgia"
    case georgiaItalic = "Georgia-Italic"
    case georgiaBold = "Georgia-Bold"
    
    // Font Family: Apple Color Emoji
    case appleColorEmoji = "AppleColorEmoji"
    
    // Font Family: Arial Rounded MT Bold
    case arialRoundedMTBold = "ArialRoundedMTBold"
    
    // Font Family: Kailasa
    case kailasaBold = "Kailasa-Bold"
    case kailasa = "Kailasa"
    
    // Font Family: Kohinoor Devanagari
    case kohinoorDevanagariLight = "KohinoorDevanagari-Light"
    case kohinoorDevanagariRegular = "KohinoorDevanagari-Regular"
    case kohinoorDevanagariSemibold = "KohinoorDevanagari-Semibold"
    
    // Font Family: Kohinoor Bangla
    case kohinoorBanglaSemibold = "KohinoorBangla-Semibold"
    case kohinoorBanglaRegular = "KohinoorBangla-Regular"
    case kohinoorBanglaLight = "KohinoorBangla-Light"
    
    // Font Family: Chalkboard SE
    case chalkboardSEBold = "ChalkboardSE-Bold"
    case chalkboardSELight = "ChalkboardSE-Light"
    case chalkboardSERegular = "ChalkboardSE-Regular"
    
    // Font Family: Sinhala Sangam MN
    case sinhalaSangamMNBold = "SinhalaSangamMN-Bold"
    case sinhalaSangamMN = "SinhalaSangamMN"
    
    // Font Family: PingFang TC
    case pingFangTCMedium = "PingFangTC-Medium"
    case pingFangTCRegular = "PingFangTC-Regular"
    case pingFangTCLight = "PingFangTC-Light"
    case pingFangTCUltralight = "PingFangTC-Ultralight"
    case pingFangTCSemibold = "PingFangTC-Semibold"
    case pingFangTCThin = "PingFangTC-Thin"
    
    // Font Family: Gujarati Sangam MN
    case gujaratiSangamMNBold = "GujaratiSangamMN-Bold"
    case gujaratiSangamMN = "GujaratiSangamMN"
    
    // Font Family: Damascus
    case damascusLight = "DamascusLight"
    case damascusBold = "DamascusBold"
    case damascusSemiBold = "DamascusSemiBold"
    case damascusMedium = "DamascusMedium"
    case damascus = "Damascus"
    
    // Font Family: Noteworthy
    case noteworthyLight = "Noteworthy-Light"
    case noteworthyBold = "Noteworthy-Bold"
    
    // Font Family: Geeza Pro
    case geezaPro = "GeezaPro"
    case geezaProBold = "GeezaPro-Bold"
    
    // Font Family: Avenir
    case avenirMedium = "Avenir-Medium"
    case avenirHeavyOblique = "Avenir-HeavyOblique"
    case avenirBook = "Avenir-Book"
    case avenirLight = "Avenir-Light"
    case avenirRoman = "Avenir-Roman"
    case avenirBookOblique = "Avenir-BookOblique"
    case avenirMediumOblique = "Avenir-MediumOblique"
    case avenirBlack = "Avenir-Black"
    case avenirBlackOblique = "Avenir-BlackOblique"
    case avenirHeavy = "Avenir-Heavy"
    case avenirLightOblique = "Avenir-LightOblique"
    case avenirOblique = "Avenir-Oblique"
    
    // Font Family: Academy Engraved LET
    case academyEngravedLetPlain = "AcademyEngravedLetPlain"
    
    // Font Family: Mishafi
    case diwanMishafi = "DiwanMishafi"
    
    // Font Family: Futura
    case futuraCondensedMedium = "Futura-CondensedMedium"
    case futuraCondensedExtraBold = "Futura-CondensedExtraBold"
    case futuraMedium = "Futura-Medium"
    case futuraMediumItalic = "Futura-MediumItalic"
    case futuraBold = "Futura-Bold"
    
    // Font Family: Farah
    case farah = "Farah"
    
    // Font Family: Kannada Sangam MN
    case kannadaSangamMN = "KannadaSangamMN"
    case kannadaSangamMNBold = "KannadaSangamMN-Bold"
    
    // Font Family: Arial Hebrew
    case arialHebrewBold = "ArialHebrew-Bold"
    case arialHebrewLight = "ArialHebrew-Light"
    case arialHebrew = "ArialHebrew"
    
    // Font Family: Arial
    case arialMT = "ArialMT"
    case arialBoldItalicMT = "Arial-BoldItalicMT"
    case arialBoldMT = "Arial-BoldMT"
    case arialItalicMT = "Arial-ItalicMT"
    
    // Font Family: Party LET
    case partyLetPlain = "PartyLetPlain"
    
    // Font Family: Chalkduster
    case chalkduster = "Chalkduster"
    
    // Font Family: Hoefler Text
    case hoeflerTextItalic = "HoeflerText-Italic"
    case hoeflerTextRegular = "HoeflerText-Regular"
    case hoeflerTextBlack = "HoeflerText-Black"
    case hoeflerTextBlackItalic = "HoeflerText-BlackItalic"
    
    // Font Family: Optima
    case optimaRegular = "Optima-Regular"
    case optimaExtraBlack = "Optima-ExtraBlack"
    case optimaBoldItalic = "Optima-BoldItalic"
    case optimaItalic = "Optima-Italic"
    case optimaBold = "Optima-Bold"
    
    // Font Family: Palatino
    case palatinoBold = "Palatino-Bold"
    case palatinoRoman = "Palatino-Roman"
    case palatinoBoldItalic = "Palatino-BoldItalic"
    case palatinoItalic = "Palatino-Italic"
    
    // Font Family: Lao Sangam MN
    case laoSangamMN = "LaoSangamMN"
    
    // Font Family: Malayalam Sangam MN
    case malayalamSangamMNBold = "MalayalamSangamMN-Bold"
    case malayalamSangamMN = "MalayalamSangamMN"
    
    // Font Family: Al Nile
    case alNileBold = "AlNile-Bold"
    case alNile = "AlNile"
    
    // Font Family: Bradley Hand
    case bradleyHandITCTTBold = "BradleyHandITCTT-Bold"
    
    // Font Family: PingFang HK
    case pingFangHKUltralight = "PingFangHK-Ultralight"
    case pingFangHKSemibold = "PingFangHK-Semibold"
    case pingFangHKThin = "PingFangHK-Thin"
    case pingFangHKLight = "PingFangHK-Light"
    case pingFangHKRegular = "PingFangHK-Regular"
    case pingFangHKMedium = "PingFangHK-Medium"
    
    // Font Family: Trebuchet MS
    case trebuchetBoldItalic = "Trebuchet-BoldItalic"
    case trebuchetMS = "TrebuchetMS"
    case trebuchetMSBold = "TrebuchetMS-Bold"
    case trebuchetMSItalic = "TrebuchetMS-Italic"
    
    // Font Family: Helvetica
    case helveticaBold = "Helvetica-Bold"
    case helvetica = "Helvetica"
    case helveticaLightOblique = "Helvetica-LightOblique"
    case helveticaOblique = "Helvetica-Oblique"
    case helveticaBoldOblique = "Helvetica-BoldOblique"
    case helveticaLight = "Helvetica-Light"
    
    // Font Family: Courier
    case courierBoldOblique = "Courier-BoldOblique"
    case courier = "Courier"
    case courierBold = "Courier-Bold"
    case courierOblique = "Courier-Oblique"
    
    // Font Family: Cochin
    case cochinBold = "Cochin-Bold"
    case cochin = "Cochin"
    case cochinItalic = "Cochin-Italic"
    case cochinBoldItalic = "Cochin-BoldItalic"
    
    // Font Family: Hiragino Mincho ProN
    case hiraMinProNW6 = "HiraMinProN-W6"
    case hiraMinProNW3 = "HiraMinProN-W3"
    
    // Font Family: Devanagari Sangam MN
    case devanagariSangamMN = "DevanagariSangamMN"
    case devanagariSangamMNBold = "DevanagariSangamMN-Bold"
    
    // Font Family: Oriya Sangam MN
    case oriyaSangamMN = "OriyaSangamMN"
    case oriyaSangamMNBold = "OriyaSangamMN-Bold"
    
    // Font Family: Snell Roundhand
    case snellRoundhandBold = "SnellRoundhand-Bold"
    case snellRoundhand = "SnellRoundhand"
    case snellRoundhandBlack = "SnellRoundhand-Black"
    
    // Font Family: Zapf Dingbats
    case zapfDingbatsITC = "ZapfDingbatsITC"
    
    // Font Family: Bodoni 72
    case bodoniSvtyTwoITCTTBold = "BodoniSvtyTwoITCTT-Bold"
    case bodoniSvtyTwoITCTTBook = "BodoniSvtyTwoITCTT-Book"
    case bodoniSvtyTwoITCTTBookIta = "BodoniSvtyTwoITCTT-BookIta"
    
    // Font Family: Verdana
    case verdanaItalic = "Verdana-Italic"
    case verdanaBoldItalic = "Verdana-BoldItalic"
    case verdana = "Verdana"
    case verdanaBold = "Verdana-Bold"
    
    // Font Family: American Typewriter
    case americanTypewriterCondensedLight = "AmericanTypewriter-CondensedLight"
    case americanTypewriter = "AmericanTypewriter"
    case americanTypewriterCondensedBold = "AmericanTypewriter-CondensedBold"
    case americanTypewriterLight = "AmericanTypewriter-Light"
    case americanTypewriterSemibold = "AmericanTypewriter-Semibold"
    case americanTypewriterBold = "AmericanTypewriter-Bold"
    case americanTypewriterCondensed = "AmericanTypewriter-Condensed"
    
    // Font Family: Avenir Next
    case avenirNextUltraLight = "AvenirNext-UltraLight"
    case avenirNextUltraLightItalic = "AvenirNext-UltraLightItalic"
    case avenirNextBold = "AvenirNext-Bold"
    case avenirNextBoldItalic = "AvenirNext-BoldItalic"
    case avenirNextDemiBold = "AvenirNext-DemiBold"
    case avenirNextDemiBoldItalic = "AvenirNext-DemiBoldItalic"
    case avenirNextMedium = "AvenirNext-Medium"
    case avenirNextHeavyItalic = "AvenirNext-HeavyItalic"
    case avenirNextHeavy = "AvenirNext-Heavy"
    case avenirNextItalic = "AvenirNext-Italic"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextMediumItalic = "AvenirNext-MediumItalic"
    
    // Font Family: Baskerville
    case baskervilleItalic = "Baskerville-Italic"
    case baskervilleSemiBold = "Baskerville-SemiBold"
    case baskervilleBoldItalic = "Baskerville-BoldItalic"
    case baskervilleSemiBoldItalic = "Baskerville-SemiBoldItalic"
    case baskervilleBold = "Baskerville-Bold"
    case baskerville = "Baskerville"
    
    // Font Family: Khmer Sangam MN
    case khmerSangamMN = "KhmerSangamMN"
    
    // Font Family: Didot
    case didotItalic = "Didot-Italic"
    case didotBold = "Didot-Bold"
    case didot = "Didot"
    
    // Font Family: Savoye LET
    case savoyeLetPlain = "SavoyeLetPlain"
    
    // Font Family: Bodoni Ornaments
    case bodoniOrnamentsITCTT = "BodoniOrnamentsITCTT"
    
    // Font Family: Symbol
    case symbol = "Symbol"
    
    // Font Family: Menlo
    case menloItalic = "Menlo-Italic"
    case menloBold = "Menlo-Bold"
    case menloRegular = "Menlo-Regular"
    case menloBoldItalic = "Menlo-BoldItalic"
    
    // Font Family: Bodoni 72 Smallcaps
    case bodoniSvtyTwoSCITCTTBook = "BodoniSvtyTwoSCITCTT-Book"
    
    // Font Family: Papyrus
    case papyrus = "Papyrus"
    case papyrusCondensed = "Papyrus-Condensed"
    
    // Font Family: Hiragino Sans
    case hiraginoSansW3 = "HiraginoSans-W3"
    case hiraginoSansW6 = "HiraginoSans-W6"
    
    // Font Family: PingFang SC
    case pingFangSCUltralight = "PingFangSC-Ultralight"
    case pingFangSCRegular = "PingFangSC-Regular"
    case pingFangSCSemibold = "PingFangSC-Semibold"
    case pingFangSCThin = "PingFangSC-Thin"
    case pingFangSCLight = "PingFangSC-Light"
    case pingFangSCMedium = "PingFangSC-Medium"
    
    // Font Family: Myanmar Sangam MN
    case myanmarSangamMNBold = "MyanmarSangamMN-Bold"
    case myanmarSangamMN = "MyanmarSangamMN"
    
    // Font Family: Euphemia UCAS
    case euphemiaUCASItalic = "EuphemiaUCAS-Italic"
    case euphemiaUCAS = "EuphemiaUCAS"
    case euphemiaUCASBold = "EuphemiaUCAS-Bold"
    
    // Font Family: Zapfino
    case zapfino = "Zapfino"
    
    // Font Family: Bodoni 72 Oldstyle
    case bodoniSvtyTwoOSITCTTBook = "BodoniSvtyTwoOSITCTT-Book"
    case bodoniSvtyTwoOSITCTTBold = "BodoniSvtyTwoOSITCTT-Bold"
    case bodoniSvtyTwoOSITCTTBookIt = "BodoniSvtyTwoOSITCTT-BookIt"
}

