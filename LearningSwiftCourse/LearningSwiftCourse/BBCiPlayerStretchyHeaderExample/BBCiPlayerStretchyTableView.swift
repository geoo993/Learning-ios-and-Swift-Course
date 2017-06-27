//
//  BBCiPlayerStretchyTableView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 27/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerStretchyTableView: UITableView {

    @IBOutlet weak var navBar : UINavigationBar!
    @IBOutlet weak var categoriesScrollView : UIScrollView!
    @IBOutlet weak var channelsScrollView : UIScrollView!
    
    let spacing : CGFloat = 10
    let categoriesItems = BBCiPlayerVideosItems.Categories.allCategories
    let channelsItems = {
        return BBCiPlayerVideosItems.Channels
        .allChannelsWithLogo
        .map{ $0.key }
    }()
    
    /*
     override init(frame: CGRect) {
     super.init(frame: frame)
     
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoriesScrollView.delegate = self
        channelsScrollView.delegate = self
        
        setCategoriesScrollViewElements()
        setChannelsScrollViewElements()
     }
     
     public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
     }

     
     public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateNavBarVisibility()
        
     }
     
    func updateNavBarVisibility (){
        
        let yPosition = self.frame.origin.y
        let difference = yPosition.percentageWithF(maxValue: -275, minValue: -284) / 100
        navBar.alpha = 1 - abs(difference)
        navBar.isHidden = (navBar.alpha < 0.05)
    }
    
    func setCategoriesScrollViewElements(){
        
        let elementwidth : CGFloat = 100
        let elementheight = categoriesScrollView.frame.size.height
        
        categoriesScrollView.removeSubviews()
        
        for i in 0..<categoriesItems.count {
            
            let element = UILabel(frame: CGRect(x: 0, y: 0, width: elementwidth, height: elementheight ))
            
            element.frame.origin.x = spacing + CGFloat(i) * elementwidth
            element.contentMode = .center
            element.text = categoriesItems[i].rawValue
            element.clipsToBounds = true
            element.layer.masksToBounds = true
            element.font = element.font.withSize(12)
            
            categoriesScrollView.addSubview(element)
            
        }
        
        //calculate the content width
        let contentWidth =  elementwidth * CGFloat(categoriesItems.count)
        
        //set scrollView content size
        categoriesScrollView.contentSize = CGSize(width: contentWidth, height: elementheight)
        
    }
    
    func setChannelsScrollViewElements(){
        
        let elementwidth : CGFloat = 100
        let elementheight = channelsScrollView.frame.size.height
        
        channelsScrollView.removeSubviews()
        
        for i in 0..<channelsItems.count {
            
            let element = UILabel(frame: CGRect(x: 0, y: 0, width: elementwidth, height: elementheight ))
            
            element.frame.origin.x = spacing + CGFloat(i) * elementwidth
            element.contentMode = .center
            element.text = channelsItems[i].rawValue
            element.clipsToBounds = true
            element.layer.masksToBounds = true
            element.font = element.font.withSize(12)
            
            channelsScrollView.addSubview(element)
            
        }
        
        //calculate the content width
        let contentWidth = elementwidth * CGFloat(channelsItems.count)
        
        //set scrollView content size
        channelsScrollView.contentSize = CGSize(width: contentWidth, height: elementheight)
        
    }
    
}

// MARK: - UIScrollViewDelegate
extension BBCiPlayerStretchyTableView : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        
        if scrollView == categoriesScrollView{
            print("categories scrollview")
        }
        
        if scrollView == channelsScrollView{
            print("channels scrollview")
        }
        
//        if let categoriesScrollview = (scrollView) as? CategoriesScrollview {
//            
//        }
//        
//        if let channelsScrollview = (scrollView) as? ChannelsScrollView {
//            
//        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //        if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
        //            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
        //        }
    }
    
}

