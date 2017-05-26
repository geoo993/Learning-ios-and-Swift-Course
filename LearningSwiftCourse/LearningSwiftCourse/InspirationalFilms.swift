//
//  InspirationalFilms.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class InspirationalFilms {
    
    var title: String
    var description : String
    var coverImage : UIImage
    var featuredImages : [UIImage?]
    var trailer : String
    var filmInfo : InspirationalFilmsInfo
    
    init(title: String, description : String, coverImage : String,filmInfo:InspirationalFilmsInfo)
    {
        self.title = title
        self.description = description
        if let img = UIImage(named: coverImage) {
            self.coverImage = img
        }else {
            self.coverImage = UIImage(named: "noImage") ?? UIImage() 
        }
        
        self.featuredImages = []
        self.trailer = ""
        self.filmInfo = filmInfo
        
    }
    
    func setFeatureImages(){
        featuredImages.removeAll()
        
        featuredImages.append(coverImage)
        featuredImages.append(UIImage(named: "pexels"))
        featuredImages.append(UIImage(named: "autumnlandscape"))
        featuredImages.append(UIImage(named: "treesfallredleaves"))
        featuredImages.append(UIImage(named: "desert"))
    }
    
    static func inspirationalFilmsList() -> [InspirationalFilms]
    {
       return [ 
        InspirationalFilms(title: "A Most Violent Year", description: "",  coverImage: "AMostViolentYear", 
                                filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Thriller])),
        InspirationalFilms(title: "The Words", description: "",coverImage: "TheWords", filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.Drama])),
        InspirationalFilms(title: "Boy Hood", description: "",coverImage: "BoyHood", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Outstanding, genres: [Genres.Family])),
        InspirationalFilms(title: "Coach Carter", description: "", coverImage: "CoachCarter", filmInfo:InspirationalFilmsInfo(year: 2005, rating: Rating.Excellent, genres: [Genres.Sport])),
        InspirationalFilms(title: "Woman In Gold", description: "",coverImage: "WomanInGold", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Outstanding, genres: [Genres.Biography])),
        InspirationalFilms(title: "The Founder", description: "",coverImage: "thefounder", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Biography])),
        InspirationalFilms(title: "Ali", description: "",coverImage: "Ali", filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "A Few Good Men", description: "",coverImage: "AFewGoodMen", filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "American Gangster", description: "",coverImage: "AmericanGangster", filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "American Sniper", description: "",coverImage: "AmericanSniper", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Awakenings", description: "",coverImage: "Awakenings", filmInfo:InspirationalFilmsInfo(year: 1990, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Bugsy", description: "",coverImage: "Bugsy", filmInfo:InspirationalFilmsInfo(year: 1991, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Casino", description: "",coverImage: "Casino", filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Catch Me If You Can", description: "",coverImage: "CatchMeIfYouCan", filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Dead Poets Society", description: "",coverImage: "DeadPoetsSociety", filmInfo:InspirationalFilmsInfo(year: 1989, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Glengarry Glen Ross", description: "",coverImage: "GlengarryGlenRoss", filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Goodfellas", description: "",coverImage: "GoodFellas", filmInfo:InspirationalFilmsInfo(year: 1990, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Joy", description: "",coverImage: "Joy", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Malcolm X", description: "",coverImage: "MalcolmX", filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Men Of Honor", description: "",coverImage: "MenOfHonor", filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Pay It Forward", description: "",coverImage: "PayItForward", filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Raging Bull", description: "",coverImage: "RagingBull", filmInfo:InspirationalFilmsInfo(year: 1980, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Schindler's List", description: "",coverImage: "SchindlersList", filmInfo:InspirationalFilmsInfo(year: 1993, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Straight Outta Compton", description: "",coverImage: "StraightOuttaCompton", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "The Aviator", description: "",coverImage: "TheAviator", filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Fences", description: "",coverImage: "Fences", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama])),
        InspirationalFilms(title: "The Hurricane", description: "",coverImage: "TheHurricane", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "The Imitation Game", description: "",coverImage: "TheImitationGame", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "The Pianist", description: "",coverImage: "ThePianist", filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "The Way Back", description: "",coverImage: "TheWayBack", filmInfo:InspirationalFilmsInfo(year: 2010, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "The Wolf Of Wall Street", description: "",coverImage: "TheWolfofWallStreet", filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Titanic", description: "",coverImage: "Titanic", filmInfo:InspirationalFilmsInfo(year: 1997, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Whiplash", description: "",coverImage: "Whiplash", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Unrated, genres: [Genres.None])),
        InspirationalFilms(title: "Rocky Balboa", description: "",coverImage: "RockyBalboa", filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "The Godfather", description: "",coverImage: "TheGodfather", filmInfo:InspirationalFilmsInfo(year: 1972, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Kung Fu Panda 3", description: "",coverImage: "KungFuPanda3", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Animation, Genres.Family])),
        InspirationalFilms(title: "Full Metal Jacket", description: "",coverImage: "FullMetalJacket", filmInfo:InspirationalFilmsInfo(year: 1987, rating: Rating.Excellent, genres: [Genres.Action, Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Zero Dark Thirty", description: "",coverImage: "ZeroDarkThirty", filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.Action, Genres.Biography, Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Cast Away", description: "",coverImage: "CastAway", filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Trading Places", description: "",coverImage: "TradingPlaces", filmInfo:InspirationalFilmsInfo(year: 1983, rating: Rating.Average, genres: [Genres.Drama, Genres.Comedy])),
        InspirationalFilms(title: "Pulp Fiction", description: "",coverImage: "PulpFiction", filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Scarface", description: "",coverImage: "Scarface", filmInfo:InspirationalFilmsInfo(year: 1983, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Room", description: "",coverImage: "Room", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Gold", description: "",coverImage: "Gold", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Point Break", description: "",coverImage: "PointBreak", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Good, genres: [Genres.Thriller, Genres.Adventure])),
        InspirationalFilms(title: "The Sixth Sense", description: "",coverImage: "TheSixthSense", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Horror])),
        InspirationalFilms(title: "AI Artificial Intelligence", description: "",coverImage: "ArtificialIntelligence", filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.SciFi, Genres.Mystery])),
        InspirationalFilms(title: "Gone Girl", description: "",coverImage: "GoneGirl", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller])),
        InspirationalFilms(title: "The Pursuit Of Happiness", description: "",coverImage: "ThePursuitOfHappiness", filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Gladiator", description: "",coverImage: "Gladiator", filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Excellent, genres: [Genres.Action, Genres.Thriller,Genres.War])),
        InspirationalFilms(title: "Remember The Titans", description: "",coverImage: "RememberTheTitans", filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Life Of PI", description: "",coverImage: "LifeOfPI", filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Good, genres: [Genres.Adventure, Genres.Fantasy])),
        InspirationalFilms(title: "The Dark Knight", description: "",coverImage: "TheDarkKnight", filmInfo:InspirationalFilmsInfo(year: 2008, rating: Rating.Outstanding, genres: [Genres.Action, Genres.Drama,Genres.Crime,Genres.Thriller])),
        InspirationalFilms(title: "Fight Club", description: "",coverImage: "FightClub", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Drama])),
        InspirationalFilms(title: "The Hunger Games", description: "",coverImage: "TheHungerGames", filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.SciFi, Genres.Action,Genres.Thriller])),
        InspirationalFilms(title: "Good Will Hunting", description: "",coverImage: "GoodWillHunting", filmInfo:InspirationalFilmsInfo(year: 1997, rating: Rating.Good, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "The Fisher King", description: "",coverImage: "TheFisherKing", filmInfo:InspirationalFilmsInfo(year: 1991, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family, Genres.Comedy])),
        InspirationalFilms(title: "Braveheart", description: "",coverImage: "Braveheart", filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.History,Genres.Biography, Genres.Romance, Genres.War])),
        InspirationalFilms(title: "The Shawshank Redemption", description: "",coverImage: "TheShawshankRedemption", filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Crime])),
        InspirationalFilms(title: "Freedom Writers", description: "",coverImage: "FreedomWriters", filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Sully", description: "",coverImage: "Sully", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Star Wars: The Empire Strikes Back", description: "",coverImage: "TheEmpireStrikesBack", filmInfo:InspirationalFilmsInfo(year: 1980, rating: Rating.Outstanding, genres: [Genres.Thriller, Genres.SciFi, Genres.Action])),
        InspirationalFilms(title: "The Notebook", description: "",coverImage: "TheNotebook", filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "A Beautiful Mind", description: "",coverImage: "ABeautifulMind", filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Heaving Is For Real", description: "",coverImage: "HeavingIsForReal", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family,Genres.Fantasy])),
        InspirationalFilms(title: "Any Given Sunday", description: "",coverImage: "AnyGivenSunday", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport,Genres.Thriller])),
        InspirationalFilms(title: "Million Dollar Arm", description: "",coverImage: "MillionDollarArm", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Money Ball", description: "",coverImage: "MoneyBall", filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Good, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Her", description: "",coverImage: "Her", filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.SciFi, Genres.Romance])),
        InspirationalFilms(title: "The Fault In Our Stars", description: "",coverImage: "TheFaultInOurStars", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "Into The Wild", description: "",coverImage: "IntoTheWild", filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Good, genres: [Genres.Family, Genres.Adventure])),
        InspirationalFilms(title: "Wild", description: "",coverImage: "Wild", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Adventure])),
        InspirationalFilms(title: "Rescue Dawn", description: "",coverImage: "RescueDawn", filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Action, Genres.Thriller, Genres.History, Genres.Biography,Genres.War])),
        InspirationalFilms(title: "Wall Street", description: "",coverImage: "WallStreet", filmInfo:InspirationalFilmsInfo(year: 1987, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Citizen Kane", description: "",coverImage: "CitizenKane", filmInfo:InspirationalFilmsInfo(year: 1941, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Lincoln", description: "",coverImage: "Lincoln", filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.History, Genres.Biography])),
        InspirationalFilms(title: "Woodlawn", description: "",coverImage: "Woodlawn", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Troy", description: "",coverImage: "Troy", filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Brilliant, genres: [Genres.Adventure, Genres.History,Genres.Action,Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Unbroken", description: "",coverImage: "Unbroken", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport,Genres.History,Genres.Biography])),
        InspirationalFilms(title: "Jerry Maguire", description: "",coverImage: "JerryMaguire", filmInfo:InspirationalFilmsInfo(year: 1996, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport,Genres.Romance])),
        InspirationalFilms(title: "Hitch", description: "",coverImage: "Hitch", filmInfo:InspirationalFilmsInfo(year: 2005, rating: Rating.Good, genres: [Genres.Drama, Genres.Romance, Genres.Comedy])),
        InspirationalFilms(title: "Steve Jobs", description: "",coverImage: "SteveJobs", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Pirates Of The Silicon Valley", description: "",coverImage: "PiratesOfTheSiliconValley", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Biography, Genres.Drama])),
        InspirationalFilms(title: "Office Space", description: "",coverImage: "OfficeSpace", filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Tinker Tailor Soldier Spy", description: "",coverImage: "TinkerTailorSoldierSpy", filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Mystery])),
        InspirationalFilms(title: "Spiderman", description: "",coverImage: "Spiderman", filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Adventure, Genres.Action, Genres.Family])),
        InspirationalFilms(title: "Nightcrawler", description: "",coverImage: "Nightcrawler", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller])),
        InspirationalFilms(title: "The Lion King", description: "",coverImage: "TheLionKing", filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Animation, Genres.Adventure])),
        InspirationalFilms(title: "I Origins", description: "",coverImage: "IOrigins", filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Mystery])),
        InspirationalFilms(title: "Pawn Sacrifice", description: "",coverImage: "PawnSacrifice", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Casablanca", description: "",coverImage: "Casablanca", filmInfo:InspirationalFilmsInfo(year: 1942, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "The Help", description: "",coverImage: "TheHelp", filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "The Big Short", description: "",coverImage: "TheBigShort", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography, Genres.Comedy])),
        InspirationalFilms(title: "The Kings Speech", description: "",coverImage: "TheKingsSpeech", filmInfo:InspirationalFilmsInfo(year: 2010, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Concussion", description: "",coverImage: "Concussion", filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport, Genres.Biography])),
        InspirationalFilms(title: "Before Sunrise", description: "",coverImage: "BeforeSunrise", filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "Hacksaw Ridge", description: "",coverImage: "HacksawRidge", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.War, Genres.Biography])),
        InspirationalFilms(title: "Tracks", description: "",coverImage: "Tracks", filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography, Genres.Adventure])),
        InspirationalFilms(title: "Spirited Away", description: "",coverImage: "SpiritedAway", filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Animation, Genres.Family])),
        InspirationalFilms(title: "Snowden", description: "",coverImage: "Snowden", filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Blood Diamond", description: "",coverImage: "BloodDiamond", filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Adventure, Genres.Thriller])),
        
        
        
        
        ]
        
    }
    
}

extension InspirationalFilms {
    
    var titleFirstLetter: String {
        return String(self.title[self.title.startIndex]).uppercased()
    }
    
}
