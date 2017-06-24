//
//  BBCiPlayerVideosItems.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

struct BBCiPlayerVideosItems {  
    
    enum Channels : String {
        case BBCOne = "BBC One"
        case BBCTwo = "BBC Two"
        case BBCThree = "BBC Three"
        case BBCFour = "BBC Four"
        case BBCRadio1 = "BBC Radio 1"
        case CBBC = "CBBC"
        case CBeeBies = "CBeeBies"
        case BBCNews = "BBC News"
        case BBCParliament = "BBC Parliament"
        case BBCAlba = "BBC Alba"
        case S4C = "S4C"

        static let allChannelsWithLogo : [BBCiPlayerVideosItems.Channels: UIImage] = 
            [
                BBCOne: #imageLiteral(resourceName: "bbc_one"),
                BBCTwo: #imageLiteral(resourceName: "bbc_two"),
                BBCThree: #imageLiteral(resourceName: "bbc_three"),
                BBCFour: #imageLiteral(resourceName: "bbc_four"),
                BBCRadio1: #imageLiteral(resourceName: "bbc_radio_1"),
                CBBC: #imageLiteral(resourceName: "bbc_cbbc"),
                CBeeBies: #imageLiteral(resourceName: "bbc_cbeebies"),
                BBCNews: #imageLiteral(resourceName: "bbc_news") ,
                BBCParliament: #imageLiteral(resourceName: "BBC_Parliament"),
                BBCAlba: #imageLiteral(resourceName: "BBC_Alba"),
                S4C: #imageLiteral(resourceName: "bbc_s4c"),
            ]
    }
    
    enum Caption : String {
        case Recommended = "RECOMMENDED"
        case NewSeries = "NEW SERIES"
        case FullSeries = "FULL SERIES"
        case LastChance = "LAST CHANCE"
        case Exclusive = "EXCLUSIVE"
        case AllNew = "ALL NEW"
        case Live = "Live"
        case None = ""
        static let captions = [Recommended,NewSeries, FullSeries, LastChance, AllNew, Live, None]
    }
    
    let channel: Channels
    let image : UIImage
    let caption : Caption
    let title: String
    let summary: String
}

extension BBCiPlayerVideosItems {
    static func bbcOneItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone1"), caption: BBCiPlayerVideosItems.Caption.None, title: "Poldark", summary: "Series 3: Episode 2"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Kat & Alfie Redwater", summary: "Series 2: Episode 5"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Panorama", summary: "London Tower Fire: Britain's Shame"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone5"), caption: BBCiPlayerVideosItems.Caption.None, title: "Broken", summary: "4 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone7"), caption: BBCiPlayerVideosItems.Caption.None, title: "EastEnders", summary: "22/06/2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone8"), caption: BBCiPlayerVideosItems.Caption.None, title: "Doctor Who", summary: "Series 10: 1. The Pilot"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone9"), caption: BBCiPlayerVideosItems.Caption.LastChance, title: "Disturbia", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone10"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Hospital People", summary: "6. The Charity Single"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone11"), caption: BBCiPlayerVideosItems.Caption.None, title: "Yes Chef", summary: "20 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone12"), caption: BBCiPlayerVideosItems.Caption.None, title: "Room 101 - Extra Storage", summary: "Series 6: Episode 4"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCOne, image : #imageLiteral(resourceName: "bbcone13"), caption: BBCiPlayerVideosItems.Caption.None, title: "Doctor Who", summary: "10 episodes"),
            
        ]
    }
    
    static func bbcTwoItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo1"), caption: BBCiPlayerVideosItems.Caption.NewSeries, title: "Hospital", summary: "Series 2: Episode 1"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo3"), caption: BBCiPlayerVideosItems.Caption.NewSeries, title: "Ripper Street", summary: "Series 5:1 Closed Casket"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Proclaimers: This is the Story", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo5"), caption: BBCiPlayerVideosItems.Caption.None, title: "Theresa vs Boris: How May Became PM", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo6"), caption: BBCiPlayerVideosItems.Caption.None, title: "Natural World", summary: "2017-2018: 5. Supercharged Otters"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo7"), caption: BBCiPlayerVideosItems.Caption.None, title: "Detectorists", summary: "Series 1: Episode 6"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo8"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Passengers That Took On the Train Line", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo9"), caption: BBCiPlayerVideosItems.Caption.None, title: "Dragons' Den", summary: "Series 14: Episode 6"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo10"), caption: BBCiPlayerVideosItems.Caption.None, title: "Trooping the Colour", summary: "Hightlights 2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCTwo, image : #imageLiteral(resourceName: "bbctwo11"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Chillenden Murders", summary: "Series 1: Episode 1"),
            
        ]
    }
    
    static func bbcThreeItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree1"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Angry Boys", summary: "12 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Murdered for Being Different", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree3"), caption: BBCiPlayerVideosItems.Caption.None, title: "Leo: Becoming a Trans man", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree4"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Pls Like", summary: "6 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree5"), caption: BBCiPlayerVideosItems.Caption.None, title: "Sexy Murder", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree6"), caption: BBCiPlayerVideosItems.Caption.None, title: "Rehab: Lives Addicted", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree7"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Queer Britain", summary: "6 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree8"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Monkey Lab", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree9"), caption: BBCiPlayerVideosItems.Caption.None, title: "Murdered by My Father", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree10"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Unsolved: The Boy Who Disappeared", summary: "1. The Night"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCThree, image : #imageLiteral(resourceName: "bbcthree11"), caption: BBCiPlayerVideosItems.Caption.None, title: "Drugs Map of Britain", summary: "8. Belfast Buds"),
        ]
    }
    static func bbcFourItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour1"), caption: BBCiPlayerVideosItems.Caption.LastChance, title: "Lemmy: The Movie", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour2"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Summer of Love: How Hippies Changed the World", summary: "series 1: Episode 2"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour3"), caption: BBCiPlayerVideosItems.Caption.None, title: "Buddy Holly: Rave On", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Legends", summary: "Doris Day: Virgin Territory"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour5"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Sky at Night", summary: "Inside God's Observatory: Special"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour6"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Cardinal", summary: "6 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour7"), caption: BBCiPlayerVideosItems.Caption.None, title: "Kenneth Williams: Fantabulosa", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour8"), caption: BBCiPlayerVideosItems.Caption.None, title: "Natural World", summary: "2012-2013: 5. Attenborough's Ark"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCFour, image : #imageLiteral(resourceName: "bbcfour9"), caption: BBCiPlayerVideosItems.Caption.None, title: "David Bowie and the Story of Ziggy Stardust", summary: ""),
            
        ]
    }
    
    static func bbcRadioItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio1"), caption: BBCiPlayerVideosItems.Caption.None, title: "NewsBeat Documentaries", summary: "Addicted to Protein"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio2"), caption: BBCiPlayerVideosItems.Caption.None, title: "The World's Most Extreme Festivals", summary: "Spring Break Cancun"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio3"), caption: BBCiPlayerVideosItems.Caption.None, title: "New York Hijabis", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio4"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Gaming Show", summary: "E3 2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio7"), caption: BBCiPlayerVideosItems.Caption.None, title: "Get Muscly In A Month", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio8"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Secret of The Fast And The Furious", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio9"), caption: BBCiPlayerVideosItems.Caption.None, title: "A Summer with Blossoms", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCRadio1, image : #imageLiteral(resourceName: "bbcradio10"), caption: BBCiPlayerVideosItems.Caption.None, title: "Hanging Out with Justin Bieber", summary: ""),
        ]
    }
    
    static func bbcCbbcItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBBC, image : #imageLiteral(resourceName: "bbccbbc1"), caption: BBCiPlayerVideosItems.Caption.None, title: "So Awkward", summary: "Series 2: 4. The Kiss"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBBC, image : #imageLiteral(resourceName: "bbccbbc2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Matilda and the Ramsay Bunch", summary: "Series 3: 8. The Wedding Anniversary"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBBC, image : #imageLiteral(resourceName: "bbccbbc3"), caption: BBCiPlayerVideosItems.Caption.None, title: "All At Sea", summary: "Series 2: 1. Valentine"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBBC, image : #imageLiteral(resourceName: "bbccbbc4"), caption: BBCiPlayerVideosItems.Caption.FullSeries, title: "Hank Zipzer Series 3", summary: "13 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBBC, image : #imageLiteral(resourceName: "bbccbbc6"), caption: BBCiPlayerVideosItems.Caption.None, title: "Remotely Funny", summary: "Series 1: 13. England"),
      
        ]
    }
    
    static func bbcCbeebiesItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBeeBies, image : #imageLiteral(resourceName: "bbccbeebies1"), caption: BBCiPlayerVideosItems.Caption.Exclusive, title: "My Petsaurus", summary: "10 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBeeBies, image : #imageLiteral(resourceName: "bbccbeebies2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Numberblocks", summary: "Series 1: Three Little Pigs"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBeeBies, image : #imageLiteral(resourceName: "bbccbeebies3"), caption: BBCiPlayerVideosItems.Caption.None, title: "Apple Tree House", summary: "Series 1: 7. Sponge Cake"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBeeBies, image : #imageLiteral(resourceName: "bbccbeebies4"), caption: BBCiPlayerVideosItems.Caption.AllNew, title: "Sarah & Duck Series 3: 21. Hair Cut", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.CBeeBies, image : #imageLiteral(resourceName: "bbccbeebies7"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Let's Go Club", summary: "Series 3: 2. A Musical, Music-full Clubhouse!"),
        ]
    }
    
    static func bbcNewsItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews1"), caption: BBCiPlayerVideosItems.Caption.None, title: "100 Days+", summary: "16 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Click", summary: "To Live and Game in LA"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews3"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Film Review", summary: "Churhill, Gifted, Whitney: Can I Be Me"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Our World", summary: "Homeless in Hawaii"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews5"), caption: BBCiPlayerVideosItems.Caption.None, title: "HARDtalk", summary: "Thuli Madonsela - Public Protector, South Africa (2009-2016)"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews6"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Travel Show", summary: "178. Bermuda"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCNews, image : #imageLiteral(resourceName: "bbcnews7"), caption: BBCiPlayerVideosItems.Caption.None, title: "BBC News Special", summary: "Finsbury Park Attack"),
        ]
    }
    
    static func bbcParliamentItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCParliament, image : #imageLiteral(resourceName: "bbcparliament2"), caption: BBCiPlayerVideosItems.Caption.None, title: "The First Lady: Nancy Astor", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCParliament, image : #imageLiteral(resourceName: "bbcparliament3"), caption: BBCiPlayerVideosItems.Caption.None, title: "House of Commons", summary: "26/04/2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCParliament, image : #imageLiteral(resourceName: "bbcparliament4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Wednesday in Parliament", summary: "21/06/2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCParliament, image : #imageLiteral(resourceName: "bbcparliament5"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Murder of Mr Perceval", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCParliament, image : #imageLiteral(resourceName: "bbcparliament6"), caption: BBCiPlayerVideosItems.Caption.None, title: "The Crumbling Palace", summary: ""),
        ]
    }
    
    static func bbcAlbaItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba1"), caption: BBCiPlayerVideosItems.Caption.None, title: "Cuimhneachan/Remembrance", summary: "Series 2: Episode 2"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Trusadh", summary: "Series 1: 4. Sùil air a' chaitheamh/Meeting victims of the White Plague"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba3"), caption: BBCiPlayerVideosItems.Caption.LastChance, title: "Opry an lùir", summary: "Series 1: Episode 4"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba4"), caption: BBCiPlayerVideosItems.Caption.None, title: "An Lot/The Croft", summary: "Series 1: Episode 6"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba6"), caption: BBCiPlayerVideosItems.Caption.None, title: "Creag nam Buthaidean/Puffin Rock", summary: "Series 1: 15 Nàbaidh Gleadhrach"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba7"), caption: BBCiPlayerVideosItems.Caption.None, title: "Puirt-adhair (Highland Airports)", summary: "Episode 2"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba8"), caption: BBCiPlayerVideosItems.Caption.None, title: "Blondie: Parallel Lines", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.BBCAlba, image : #imageLiteral(resourceName: "bbcalba10"), caption: BBCiPlayerVideosItems.Caption.None, title: "Padraig Post SDS", summary: "15. Seud Sealbhach (A Magical Jewel)"),
        ]
    }
    
    static func bbcS4CItems () -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c2"), caption: BBCiPlayerVideosItems.Caption.None, title: "Mynyddoedd y Byd", summary: "Mynyddoedd y Byd: Y Rwenzori"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c3"), caption: BBCiPlayerVideosItems.Caption.None, title: "Llewod '71", summary: ""),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c4"), caption: BBCiPlayerVideosItems.Caption.None, title: "Ffermio", summary: "Mon, 19 Jun 2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c5"), caption: BBCiPlayerVideosItems.Caption.None, title: "Eisteddfod yr Urdd", summary: "2017: Goreuon y Caneuon Actol"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c6"), caption: BBCiPlayerVideosItems.Caption.None, title: "Gerddi Cymru", summary: "Cyfres 1: Erddig"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c7"), caption: BBCiPlayerVideosItems.Caption.None, title: "Garddio a Mwy", summary: "3 episodes"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c8"), caption: BBCiPlayerVideosItems.Caption.None, title: "Pobol y Cwm", summary: "Thu, 22 Jun 2017"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c9"), caption: BBCiPlayerVideosItems.Caption.None, title: "Stiwdio Gefn", summary: "Cyfres 5: Pennod 7"),
            BBCiPlayerVideosItems(channel: BBCiPlayerVideosItems.Channels.S4C, image : #imageLiteral(resourceName: "bbcs4c10"), caption: BBCiPlayerVideosItems.Caption.None, title: "Rownd a Rownd", summary: "Cyfres 22: Pennod 52"),
        ]
    }
    
    static func allChannelsItems() -> [BBCiPlayerVideosItems] {
        return [
            BBCiPlayerVideosItems.bbcOneItems(),
            BBCiPlayerVideosItems.bbcTwoItems(),
            BBCiPlayerVideosItems.bbcThreeItems(),
            BBCiPlayerVideosItems.bbcFourItems(),
            BBCiPlayerVideosItems.bbcRadioItems(),
            BBCiPlayerVideosItems.bbcCbbcItems(),
            BBCiPlayerVideosItems.bbcCbeebiesItems(),
            BBCiPlayerVideosItems.bbcNewsItems(),
            BBCiPlayerVideosItems.bbcParliamentItems(),
            BBCiPlayerVideosItems.bbcAlbaItems(),
            BBCiPlayerVideosItems.bbcS4CItems()
        ].flatMap{ $0}
    }
    
}
