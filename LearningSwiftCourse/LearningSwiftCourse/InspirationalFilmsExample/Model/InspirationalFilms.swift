//
//  InspirationalFilms.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class InspirationalFilms {
    
    var title: String
    var description : String
    var coverImage : UIImage
    var coverImageName : String
    var maxImage : Int
    var featuredImages : [UIImage?]
    var featuredImagesSubject = ReplaySubject<( [UIImage?] )>.create(bufferSize: 1)
    var maxVideos : Int
    var featuredVideos : [String]
    var trailer : String
    var filmInfo : InspirationalFilmsInfo
    let as3URL = "https://s3.eu-west-2.amazonaws.com/inspirationalfilmsscenes/"
    var downloaded = false
    var disposeBag = DisposeBag()
    
    init(title: String, description : String, coverImage : String, maxImage : Int, maxVideos : Int, filmInfo:InspirationalFilmsInfo)
    {
        self.title = title
        self.description = description
        if let img = UIImage(named: coverImage) {
            self.coverImage = img
        }else {
            self.coverImage = UIImage(named: "noImage") ?? UIImage() 
        }
        self.coverImageName = coverImage
        self.featuredImages = []
        self.featuredVideos = []
        self.trailer = ""
        self.filmInfo = filmInfo
        self.maxImage = maxImage
        self.maxVideos = maxVideos
        self.downloaded = true
    }
    
    func setFeatureImages(){
        
        featuredImages.removeAll()
        
        featuredImages.append(coverImage)
        
        if maxImage > 0{
            let tempImageNamesIndex = [0..<maxImage].flatMap{$0}
            let tempFilmsImages = tempImageNamesIndex.enumerated().map{ UIImage(named:"TheWords\( ($0.offset + 1) )")}
            featuredImages.append(contentsOf: tempFilmsImages)

        }
        
        /*
        let imagesURL = as3URL + "\(coverImageName)/\(coverImageName)Images/\(coverImageName)"
        
        
        
        if maxImage > 0 && downloaded {
            
            let backgroundScheduler = SerialDispatchQueueScheduler(qos: .background)
            Observable.just()
                .observeOn(backgroundScheduler)
                .map { [weak self] _ -> [UIImage?] in
                    guard let this = self else { return [] }
                    
                    return [0..<this.maxImage].flatMap{$0}.map{ (num) -> UIImage? in
                        var img =  UIImage(named: "noImage")
                        let url = imagesURL + "\( (num + 1) ).png"
                        
                        if let url = URL(string: url) {
                            if let data = try? Data(contentsOf: url) {
                                DispatchQueue.main.async(execute: {
                                    if let image = UIImage(data: data) {
                                        img =  image
                                    }
                                })
                            }
                        }
                        
                        return img
                    }
                }
                .observeOn(MainScheduler.instance)
                .bindTo(featuredImagesSubject)
                .disposed(by: disposeBag)

            
            
//                let url = imagesURL + "\( (num + 1) ).png"
//                return UIImage.setImageFromURl(stringImageUrl: url)
//                    if let url = URL(string: url) {
//                        if let data = try? Data(contentsOf: url) {
//                            DispatchQueue.main.async(execute: {
//                                if let image = UIImage(data: data) {
//                                    print("new image at:", num + 1)
//                                }
//                            })
//                           
//            }
            
            featuredImagesSubject
            .subscribe(onNext: {[weak self] images in 
                guard let this = self else { return }
                print("all Images")
                this.featuredImages.append(contentsOf: images)
            }).disposed(by: disposeBag)
            
            //featuredImages.append(contentsOf: images)
            downloaded = false
        }
 
         */
            
    }
    func setFeatureVideos(){
        
        featuredVideos.removeAll()
        let videosURL = as3URL + "\(coverImageName)/\(coverImageName)"
        if maxVideos > 0 {
            let tempVideoNamesIndex = [0..<maxVideos].flatMap{$0}
            let tempFilmsVideos = tempVideoNamesIndex.enumerated().map{ videosURL + "\( ($0.offset + 1) ).mp4"}
            featuredVideos.append(contentsOf: tempFilmsVideos)
            
        }
    }
    
    static func inspirationalFilmsList() -> [InspirationalFilms]
    {
       return [ 
        InspirationalFilms(title: "A Most Violent Year", description: "",  coverImage: "AMostViolentYear", maxImage: 0, maxVideos : 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Crime])),
        InspirationalFilms(title: "The Words", description: "",coverImage: "TheWords", maxImage: 32, maxVideos: 3, filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Romance, Genres.Mystery])),
        InspirationalFilms(title: "Boy Hood", description: "",coverImage: "BoyHood", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Outstanding, genres: [Genres.Family])),
        InspirationalFilms(title: "Coach Carter", description: "", coverImage: "CoachCarter", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2005, rating: Rating.Excellent, genres: [Genres.Biography,Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Woman In Gold", description: "",coverImage: "WomanInGold", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Outstanding, genres: [Genres.Biography,Genres.Drama,Genres.History])),
        InspirationalFilms(title: "The Founder", description: "",coverImage: "TheFounder", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Drama,Genres.Biography,Genres.History])),
    
        InspirationalFilms(title: "Ali", description: "",coverImage: "Ali", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Brilliant, genres: [Genres.Biography,Genres.Sport,Genres.Drama])),
        InspirationalFilms(title: "A Few Good Men", description: "",coverImage: "AFewGoodMen", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Thriller])),
        InspirationalFilms(title: "American Gangster", description: "",coverImage: "AmericanGangster", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Excellent, genres: [Genres.Drama,Genres.Crime,Genres.Biography])),
        InspirationalFilms(title: "American Sniper", description: "",coverImage: "AmericanSniper", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Action,Genres.Crime,Genres.Biography])),
        InspirationalFilms(title: "Awakenings", description: "",coverImage: "Awakenings", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1990, rating: Rating.Brilliant, genres: [Genres.Drama,Genres.Biography])),
        InspirationalFilms(title: "Bugsy", description: "",coverImage: "Bugsy", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1991, rating: Rating.Excellent, genres: [Genres.Biography, Genres.Drama, Genres.Crime])),
        InspirationalFilms(title: "Casino", description: "",coverImage: "Casino", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Crime])),
        InspirationalFilms(title: "Catch Me If You Can", description: "",coverImage: "CatchMeIfYouCan", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Outstanding, genres: [Genres.Drama,Genres.Crime])),
        InspirationalFilms(title: "Dead Poets Society", description: "",coverImage: "DeadPoetsSociety", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1989, rating: Rating.Outstanding, genres: [Genres.Drama,Genres.Comedy])),
        InspirationalFilms(title: "Glengarry Glen Ross", description: "",coverImage: "GlengarryGlenRoss", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Goodfellas", description: "",coverImage: "GoodFellas", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1990, rating: Rating.Excellent, genres: [Genres.Crime,Genres.Drama])),
        InspirationalFilms(title: "Joy", description: "",coverImage: "Joy", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Malcolm X", description: "",coverImage: "MalcolmX", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1992, rating: Rating.Excellent, genres: [Genres.History,Genres.Biography,Genres.Drama])),
        InspirationalFilms(title: "Men Of Honor", description: "",coverImage: "MenOfHonor", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Brilliant, genres: [Genres.Biography, Genres.Drama])),
        InspirationalFilms(title: "Pay It Forward", description: "",coverImage: "PayItForward", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Outstanding, genres: [Genres.Drama])),
        InspirationalFilms(title: "Raging Bull", description: "",coverImage: "RagingBull", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1980, rating: Rating.Excellent, genres: [Genres.Drama,Genres.Sport,Genres.Biography])),
        InspirationalFilms(title: "Schindler's List", description: "",coverImage: "SchindlersList", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1993, rating: Rating.Outstanding, genres: [Genres.Drama,Genres.History,Genres.Biography])),
        InspirationalFilms(title: "Straight Outta Compton", description: "",coverImage: "StraightOuttaCompton", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Excellent, genres: [Genres.Drama,Genres.History,Genres.Biography])),
        InspirationalFilms(title: "The Aviator", description: "",coverImage: "TheAviator", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Brilliant, genres: [Genres.Drama,Genres.History,Genres.Biography])),
        InspirationalFilms(title: "Fences", description: "",coverImage: "Fences", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama])),
        InspirationalFilms(title: "The Hurricane", description: "",coverImage: "TheHurricane", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Excellent, genres: [Genres.Biography,Genres.Sport,Genres.Drama])),
        InspirationalFilms(title: "The Imitation Game", description: "",coverImage: "TheImitationGame", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Biography,Genres.Thriller,Genres.Drama])),
        InspirationalFilms(title: "The Pianist", description: "",coverImage: "ThePianist", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Outstanding, genres: [Genres.War,Genres.Biography,Genres.Drama])),
        InspirationalFilms(title: "The Way Back", description: "",coverImage: "TheWayBack", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2010, rating: Rating.Excellent, genres: [Genres.Adventure,Genres.History,Genres.Drama])),
        InspirationalFilms(title: "The Wolf Of Wall Street", description: "",coverImage: "TheWolfofWallStreet", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Brilliant, genres: [Genres.Drama,Genres.Comedy])),
        InspirationalFilms(title: "Titanic", description: "",coverImage: "Titanic", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1997, rating: Rating.Brilliant, genres: [Genres.Drama,Genres.Romance])),
        InspirationalFilms(title: "Whiplash", description: "",coverImage: "Whiplash", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama])),
        
        InspirationalFilms(title: "Rocky Balboa", description: "",coverImage: "RockyBalboa", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "The Godfather", description: "",coverImage: "TheGodfather", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1972, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Kung Fu Panda 3", description: "",coverImage: "KungFuPanda3", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Animation, Genres.Family])),
        InspirationalFilms(title: "Full Metal Jacket", description: "",coverImage: "FullMetalJacket", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1987, rating: Rating.Excellent, genres: [Genres.Action, Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Zero Dark Thirty", description: "",coverImage: "ZeroDarkThirty", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.Action, Genres.Biography, Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Cast Away", description: "",coverImage: "CastAway", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Trading Places", description: "",coverImage: "TradingPlaces", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1983, rating: Rating.Average, genres: [Genres.Drama, Genres.Comedy])),
        InspirationalFilms(title: "Pulp Fiction", description: "",coverImage: "PulpFiction", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Scarface", description: "",coverImage: "Scarface", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1983, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Crime])),
        InspirationalFilms(title: "Room", description: "",coverImage: "Room", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Gold", description: "",coverImage: "Gold", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Point Break", description: "",coverImage: "PointBreak", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Good, genres: [Genres.Thriller, Genres.Adventure])),
        InspirationalFilms(title: "The Sixth Sense", description: "",coverImage: "TheSixthSense", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Horror])),
        InspirationalFilms(title: "AI Artificial Intelligence", description: "",coverImage: "ArtificialIntelligence", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.SciFi, Genres.Mystery])),
        InspirationalFilms(title: "Gone Girl", description: "",coverImage: "GoneGirl", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller])),
        InspirationalFilms(title: "The Pursuit Of Happiness", description: "",coverImage: "ThePursuitOfHappiness", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Gladiator", description: "",coverImage: "Gladiator", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Excellent, genres: [Genres.Action, Genres.Thriller,Genres.War])),
        InspirationalFilms(title: "Remember The Titans", description: "",coverImage: "RememberTheTitans", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2000, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Life Of PI", description: "",coverImage: "LifeOfPI", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Good, genres: [Genres.Adventure, Genres.Fantasy])),
        InspirationalFilms(title: "The Dark Knight", description: "",coverImage: "TheDarkKnight", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2008, rating: Rating.Outstanding, genres: [Genres.Action, Genres.Drama,Genres.Crime,Genres.Thriller])),
        InspirationalFilms(title: "Fight Club", description: "",coverImage: "FightClub", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Drama])),
        InspirationalFilms(title: "The Hunger Games", description: "",coverImage: "TheHungerGames", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.SciFi, Genres.Action,Genres.Thriller])),
        InspirationalFilms(title: "Good Will Hunting", description: "",coverImage: "GoodWillHunting", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1997, rating: Rating.Good, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "The Fisher King", description: "",coverImage: "TheFisherKing", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1991, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family, Genres.Comedy])),
        InspirationalFilms(title: "Braveheart", description: "",coverImage: "Braveheart", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.History,Genres.Biography, Genres.Romance, Genres.War])),
        InspirationalFilms(title: "The Shawshank Redemption", description: "",coverImage: "TheShawshankRedemption", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Crime])),
        InspirationalFilms(title: "Freedom Writers", description: "",coverImage: "FreedomWriters", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Sully", description: "",coverImage: "Sully", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Star Wars: The Empire Strikes Back", description: "",coverImage: "TheEmpireStrikesBack", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1980, rating: Rating.Outstanding, genres: [Genres.Thriller, Genres.SciFi, Genres.Action])),
        InspirationalFilms(title: "The Notebook", description: "",coverImage: "TheNotebook", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "A Beautiful Mind", description: "",coverImage: "ABeautifulMind", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "Heaving Is For Real", description: "",coverImage: "HeavingIsForReal", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Family,Genres.Fantasy])),
        InspirationalFilms(title: "Any Given Sunday", description: "",coverImage: "AnyGivenSunday", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport,Genres.Thriller])),
        InspirationalFilms(title: "Million Dollar Arm", description: "",coverImage: "MillionDollarArm", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Money Ball", description: "",coverImage: "MoneyBall", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Good, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Her", description: "",coverImage: "Her", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.SciFi, Genres.Romance])),
        InspirationalFilms(title: "The Fault In Our Stars", description: "",coverImage: "TheFaultInOurStars", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "Into The Wild", description: "",coverImage: "IntoTheWild", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2007, rating: Rating.Good, genres: [Genres.Family, Genres.Adventure])),
        InspirationalFilms(title: "Wild", description: "",coverImage: "Wild", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Adventure])),
        InspirationalFilms(title: "Rescue Dawn", description: "",coverImage: "RescueDawn", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Action, Genres.Thriller, Genres.History, Genres.Biography,Genres.War])),
        InspirationalFilms(title: "Wall Street", description: "",coverImage: "WallStreet", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1987, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Citizen Kane", description: "",coverImage: "CitizenKane", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1941, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Lincoln", description: "",coverImage: "Lincoln", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2012, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.History, Genres.Biography])),
        InspirationalFilms(title: "Woodlawn", description: "",coverImage: "Woodlawn", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport])),
        InspirationalFilms(title: "Troy", description: "",coverImage: "Troy", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2004, rating: Rating.Brilliant, genres: [Genres.Adventure, Genres.History,Genres.Action,Genres.Thriller, Genres.War])),
        InspirationalFilms(title: "Unbroken", description: "",coverImage: "Unbroken", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport,Genres.History,Genres.Biography])),
        InspirationalFilms(title: "Jerry Maguire", description: "",coverImage: "JerryMaguire", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1996, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Sport,Genres.Romance])),
        InspirationalFilms(title: "Hitch", description: "",coverImage: "Hitch", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2005, rating: Rating.Good, genres: [Genres.Drama, Genres.Romance, Genres.Comedy])),
        InspirationalFilms(title: "Steve Jobs", description: "",coverImage: "SteveJobs", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Pirates Of The Silicon Valley", description: "",coverImage: "PiratesOfTheSiliconValley", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Brilliant, genres: [Genres.Biography, Genres.Drama])),
        InspirationalFilms(title: "Office Space", description: "",coverImage: "OfficeSpace", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1999, rating: Rating.Excellent, genres: [Genres.Drama])),
        InspirationalFilms(title: "Tinker Tailor Soldier Spy", description: "",coverImage: "TinkerTailorSoldierSpy", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Thriller, Genres.Mystery])),
        InspirationalFilms(title: "Spiderman", description: "",coverImage: "Spiderman", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Adventure, Genres.Action, Genres.Family])),
        InspirationalFilms(title: "Nightcrawler", description: "",coverImage: "Nightcrawler", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Thriller])),
        InspirationalFilms(title: "The Lion King", description: "",coverImage: "TheLionKing", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1994, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Animation, Genres.Adventure])),
        InspirationalFilms(title: "I Origins", description: "",coverImage: "IOrigins", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2014, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Mystery])),
        InspirationalFilms(title: "Pawn Sacrifice", description: "",coverImage: "PawnSacrifice", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Casablanca", description: "",coverImage: "Casablanca", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1942, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "The Help", description: "",coverImage: "TheHelp", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2011, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Family])),
        InspirationalFilms(title: "The Big Short", description: "",coverImage: "TheBigShort", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography, Genres.Comedy])),
        InspirationalFilms(title: "The Kings Speech", description: "",coverImage: "TheKingsSpeech", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2010, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Concussion", description: "",coverImage: "Concussion", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2015, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Sport, Genres.Biography])),
        InspirationalFilms(title: "Before Sunrise", description: "",coverImage: "BeforeSunrise", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 1995, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Romance])),
        InspirationalFilms(title: "Hacksaw Ridge", description: "",coverImage: "HacksawRidge", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.War, Genres.Biography])),
        InspirationalFilms(title: "Tracks", description: "",coverImage: "Tracks", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2013, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Biography, Genres.Adventure])),
        InspirationalFilms(title: "Spirited Away", description: "",coverImage: "SpiritedAway", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2001, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Animation, Genres.Family])),
        InspirationalFilms(title: "Snowden", description: "",coverImage: "Snowden", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.Biography])),
        InspirationalFilms(title: "Blood Diamond", description: "",coverImage: "BloodDiamond", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2006, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Adventure, Genres.Thriller])),
        InspirationalFilms(title: "Lord Of The Rings: The Two Towers", description: "",coverImage: "LordOfTheRingsTheTwoTowers", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2002, rating: Rating.Brilliant, genres: [Genres.Drama, Genres.Adventure, Genres.Fantasy])),
        InspirationalFilms(title: "Lord Of War", description: "",coverImage: "LordOfWar", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2005, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Crime, Genres.Thriller])),
        InspirationalFilms(title: "The Finest Hours", description: "",coverImage: "TheFinestHours", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Good, genres: [Genres.Drama, Genres.Action, Genres.History])),
        InspirationalFilms(title: "Ip Man", description: "",coverImage: "IpMan", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2008, rating: Rating.Excellent, genres: [Genres.Drama, Genres.Action, Genres.Biography])),
        InspirationalFilms(title: "All The Way", description: "",coverImage: "AllTheWay", maxImage: 0, maxVideos: 0, filmInfo:InspirationalFilmsInfo(year: 2016, rating: Rating.Outstanding, genres: [Genres.Drama, Genres.History, Genres.Biography])),
        
        ]
        
    }
    
}

extension InspirationalFilms {
    
    var titleFirstLetter: String {
        return String(self.title[self.title.startIndex]).uppercased()
    }
    
    static func sortedInspirationalFilms() -> [InspirationalFilms] {
        return InspirationalFilms
            .inspirationalFilmsList()
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == ComparisonResult.orderedAscending }
    }
    
    static func getCurrentFilm(_ title: String, sorted: Bool) -> InspirationalFilms? {
        let films = sorted ? 
            InspirationalFilms.sortedInspirationalFilms() 
            : InspirationalFilms.inspirationalFilmsList()
        return films.filter{ $0.title == title }.first
    }
    
    static func getSelectedFilmIndex(film: InspirationalFilms, sorted:Bool) -> Int? {
        let films = sorted ? 
            InspirationalFilms.sortedInspirationalFilms() 
            : InspirationalFilms.inspirationalFilmsList()
        return films.index(where: {$0.title == film.title})
    }
    
}
