//
//  ProductLine.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 12/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation


class ProductLine {
    
    
    var productType : String
    var products : [Product]
    
    init(productType: String, includedProducts: [Product]){
        
        self.productType = productType
        self.products = includedProducts
    }
    
    class var allProducts : Int {
        
        get {
            return (ProductLine.films().products.count + ProductLine.tvSeries().products.count +
                ProductLine.videoGames().products.count + ProductLine.music().products.count + ProductLine.books().products.count)
            
        }
    }
    
    
    class func productLines() -> [ProductLine]
    {
    
        return [self.films(), self.videoGames(), self.tvSeries(), self.music (), self.books()]
    }
    
    class func films () -> ProductLine
    {
        var products = [Product]()
        
        products.append(Product(title: "A Most Violent Year", 
            description: "In 1981 New York, a fuel supplier (Oscar Isaac) tries to adhere to his own moral compass amid the rampant violence, corruption and decay that threaten his family and his business.",  imageName: "AMostViolentYear", year: 2015, rating: Rating.Brilliant, genres: [Genres.Thriller]))
        
        products.append(Product(title: "The Words", description: "When shallow wannabe-writer Rory (Bradley Cooper) finds an old manuscript tucked away in a bag, he decides to pass the work off as his own. The book, called \"The Window Tears,\" brings Rory great acclaim, until the real author (Jeremy Irons) shows up and threatens to destroy Rory's reputation. Cut to Clayton Hammond (Dennis Quaid), a writer whose popular novel \"The Words\" seems to mirror Rory's story, leading to speculation that the tome is Hammond's thinly veiled autobiography.",imageName: "TheWords", year: 2012, rating: Rating.Brilliant, genres: [Genres.Drama]))
        
         products.append(Product(title: "Boy Hood", description: "The joys and pitfalls of growing up are seen through the eyes of a child named Mason (Ellar Coltrane), his parents (Patricia Arquette, Ethan Hawke) and his sister (Lorelei Linklater). Vignettes, filmed with the same cast over the course of 12 years, capture family meals, road trips, birthday parties, graduations and other important milestones. Songs from Coldplay, Arcade Fire and other artists capture the time period. Directed by Richard Linklater.",imageName: "BoyHood", year: 2014, rating: Rating.Outstanding, genres: [Genres.Family]))
        
        products.append(Product(title: "Coach Carter", description: "In 1999, Ken Carter (Samuel L. Jackson) returns to his old high school in Richmond, California, to get the basketball team into shape. With tough rules and academic discipline, he succeeds in setting the players on a winning streak. But when their grades start to suffer, Carter locks them out of the gym and shuts down their championship season. When he is criticized by the players and their parents, he sticks to his guns, determined that they excel in class as well as on the court.",imageName: "CoachCarter", year: 2005, rating: Rating.Excellent, genres: [Genres.Sport]))
        
        products.append(Product(title: "Woman In Gold", description: "Sixty years after fleeing Vienna, Maria Altmann (Helen Mirren), an elderly Jewish woman, attempts to reclaim family possessions that were seized by the Nazis. Among them is a famous portrait of Maria's beloved Aunt Adele: Gustave Klimt's \"Portrait of Adele Bloch-Bauer I.\" With the help of young lawyer Randy Schoeberg (Ryan Reynolds), Maria embarks upon a lengthy legal battle to recover this painting and several others, but it will not be easy, for Austria considers them national treasures.",imageName: "WomanInGold", year: 2015, rating: Rating.Outstanding, genres: [Genres.Biography]))
        
        products.append(Product(title: "The Founder", description: "The story of Ray Kroc, a salesman who turned two brothers' innovative fast food eatery, McDonald's, into one of the biggest restaurant businesses in the world with a combination of ambition, persistence, and ruthlessness.",imageName: "thefounder", year: 2016, rating: Rating.Excellent, genres: [Genres.Biography]))
        
        products.append(Product(title: "Ali", description: "",imageName: "Ali", year: 2001, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "A Few Good Men", description: "",imageName: "AFewGoodMen", year: 1992, rating: Rating.Unrated, genres: [Genres.None]))
        
        products.append(Product(title: "American Gangster", description: "",imageName: "AmericanGangster", year: 2007, rating: Rating.Unrated, genres: [Genres.None]))
        
        products.append(Product(title: "American Sniper", description: "",imageName: "AmericanSniper", year: 2014, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Awakenings", description: "",imageName: "Awakenings", year: 1990, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Bugsy", description: "",imageName: "Bugsy", year: 1991, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Casino", description: "",imageName: "Casino", year: 1995, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Catch Me If You Can", description: "",imageName: "CatchMeIfYouCan", year: 2002, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Dead Poets Society", description: "",imageName: "DeadPoetsSociety", year: 1989, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Freedom Writers", description: "",imageName: "FreedomWriters", year: 2007, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Glengarry Glen Ross", description: "",imageName: "GlengarryGlenRoss", year: 1992, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Goodfellas", description: "",imageName: "GoodFellas", year: 1990, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Joy", description: "",imageName: "Joy", year: 2015, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Malcolm X", description: "",imageName: "MalcolmX", year: 1992, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Men Of Honor", description: "",imageName: "MenOfHonor", year: 2000, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Pay It Forward", description: "",imageName: "PayItForward", year: 2000, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Raging Bull", description: "",imageName: "RagingBull", year: 1980, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Schindler's List", description: "",imageName: "SchindlersList", year: 1993, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Straight Outta Compton", description: "",imageName: "StraightOuttaCompton", year: 2015, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Aviator", description: "",imageName: "TheAviator", year: 2004, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Big Short", description: "",imageName: "TheBigShort", year: 2015, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Devil's Double", description: "",imageName: "TheDevilsDouble", year: 2011, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Hurricane", description: "",imageName: "TheHurricane", year: 1999, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Imitation Game", description: "",imageName: "TheImitationGame", year: 2014, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Pianist", description: "",imageName: "ThePianist", year: 2002, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Way Back", description: "",imageName: "TheWayBack", year: 2010, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "The Wolf Of Wall Street", description: "",imageName: "TheWolfofWallStreet", year: 2013, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Titanic", description: "",imageName: "Titanic", year: 1997, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Tracks", description: "",imageName: "Tracks", year: 2013, rating: Rating.Unrated, genres: [Genres.None]))
        products.append(Product(title: "Whiplash", description: "",imageName: "Whiplash", year: 2014, rating: Rating.Unrated, genres: [Genres.None]))
            
        
        return ProductLine(productType: "Movies", includedProducts: products)
        
    }
    
    
    class func videoGames () -> ProductLine
    {
        var products = [Product]()
        products.append(Product(title: "Doom", description: "Doom is played entirely from a first-person perspective, with players taking the role of an unnamed marine, as he battles demonic forces from Hell that have been unleashed by the Union Aerospace Corporation on a future-set colonized planet Mars.",imageName: "Doom.jpg", year: 2016, rating: Rating.Good, genres: [Genres.Horror]))
        products.append(Product(title: "Uncharted", description: "Uncharted 4: A Thief's End is the sequel to 2011's Uncharted 3: Drake's Deception, it is the conclusion to the Uncharted series starring Nathan Drake, and the last game in the franchise to be developed by Naughty Dog.",imageName: "Uncharted4", year: 2016, rating: Rating.Outstanding, genres: [Genres.Action, Genres.Adventure]))
        
        products.append(Product(title: "No Man's Sky", description: "The gameplay of No Man's Sky is built on four pillars: exploration, survival, combat, and trading. Players are free to perform within the entirety of a procedurally generated deterministic open universe, which includes over 18 quintillion (1.8×1019) planets, many with their own sets of flora and fauna. Players participate in a shared universe, with the ability to exchange planet information with other players, though the game is also fully playable offline; this is enabled by the procedural generation system that assures players find the same planet with the same features, lifeforms, and other aspects once given the planet coordinates, requiring no further data to be stored or retrieved from game servers. Nearly all elements of the game are procedurally generated, including star systems, planets and their ecosystems, flora, fauna and their behavioural patterns, artificial structures, and alien factions and their spacecraft.",imageName: "NoMansSky", year: 2016, rating: Rating.Excellent, genres: [Genres.Adventure]))
        return ProductLine(productType: "Video Games", includedProducts: products)
    }
    
    class func books () -> ProductLine
    {
        var products = [Product]()
        products.append(Product(title: "No Book", description: "Sorry Can't Compile ",imageName: "", year: 0, rating: Rating.Unrated, genres: [Genres.None]))
        return ProductLine(productType: "Books", includedProducts: products)
    }
    
    class func tvSeries () -> ProductLine
    {
        var products = [Product]()
//        products.append(Product(title: "No TV Series", description: "Sorry Can't Compile ",imageName: "", year: 0, rating: Rating.Unrated, genres: [Genres.None]))
//        
        products.append(Product(title: "Billions", 
                                description: "U.S. Attorney Chuck Rhoades goes after hedge fund king, Bobby \"Axe\" Axelrod in a battle between two powerful New York figures.",  imageName: "billions", year: 2016, rating: Rating.Brilliant, genres: [Genres.Drama]))
        
        products.append(Product(title: "Homeland", description: "A bipolar CIA operative becomes convinced a prisoner of war has been turned by al-Qaeda and is planning to carry out a terrorist attack on American soil.",imageName: "homeland", year: 2011, rating: Rating.Outstanding, genres: [Genres.Crime, Genres.Drama]))
        
        products.append(Product(title: "Vikings", description: "The world of the Vikings is brought to life through the journey of Ragnar Lothbrok, the first Viking to emerge from Norse legend and onto the pages of history - a man on the edge of myth.",imageName: "vikings", year: 2013, rating: Rating.Excellent, genres: [Genres.Action,Genres.Drama, Genres.History]))
        
        products.append(Product(title: "Game of Thrones", description: "Nine noble families fight for control over the mythical lands of Westeros; A forgotten race returns after being dormant for thousands of years.",imageName: "gameofthrones", year: 2011, rating: Rating.Outstanding, genres: [Genres.Adventure, Genres.Drama,Genres.Fantasy]))
        
        products.append(Product(title: "Breaking Bad", description: "A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine in order to secure his family's future.",imageName: "breakingbad", year: 2008, rating: Rating.Brilliant, genres: [Genres.Crime,Genres.Drama, Genres.Thriller]))
        
        products.append(Product(title: "House of Cards", description: "A Congressman works with his equally conniving wife to exact revenge on the people who betrayed him.",imageName: "houseofcards", year: 2013, rating: Rating.Excellent, genres: [Genres.Drama]))
        
        products.append(Product(title: "Scandal", description: "A former White House Communications Director starts her own crisis management firm only to realize her clients are not the only ones with secrets.",imageName: "scandal", year: 2012, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller]))
        
        products.append(Product(title: "Westworld", description: "Set at the intersection of the near future and the reimagined past, explore a world in which every human appetite, no matter how noble or depraved, can be indulged without consequence.",imageName: "westworld", year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama,Genres.SciFi]))
        
        products.append(Product(title: "Preacher", description: "After a supernatural event at his church, a preacher enlists the help of a vampire to find God.",imageName: "preacher", year: 2016, rating: Rating.Excellent, genres: [Genres.Adventure,Genres.Drama,Genres.Fantasy]))
        
        products.append(Product(title: "24", description: "Jack Bauer, Director of Field Ops for the Counter-Terrorist Unit of Los Angeles, races against the clock to subvert terrorist plots and save his nation from ultimate disaster.",imageName: "24series", year: 2001, rating: Rating.Brilliant, genres: [Genres.Action,Genres.Crime,Genres.Drama]))
        
        products.append(Product(title: "Prison Break", description: "Due to a political conspiracy, an innocent man is sent to death row and his only hope is his brother, who makes it his mission to deliberately get himself sent to the same prison in order to break the both of them out, from the inside.",imageName: "prisonbreak", year: 2005, rating: Rating.Outstanding, genres: [Genres.Action,Genres.Crime,Genres.Drama]))
        
        return ProductLine(productType: "TV Series", includedProducts: products)
    }
    
    class func music () -> ProductLine
    {
        var products = [Product]()
        products.append(Product(title: "No Music", description: "Sorry Can't Compile ",imageName: "", year: 0, rating: Rating.Unrated, genres: [Genres.None]))
        return ProductLine(productType: "Music", includedProducts: products)
    }
    
}
