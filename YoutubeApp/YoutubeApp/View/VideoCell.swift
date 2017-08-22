//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by GEORGE QUENTIN on 13/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

//https://www.letsbuildthatapp.com/course_video?id=64

import UIKit

class VideoCell: BaseCell {
    let leftSpacing : CGFloat = 16
    let rightSpacing : CGFloat = 16
    let midSpacing : CGFloat = 8
    let topSpacing : CGFloat = 4
    let bottomSpacing : CGFloat = 4
    
    var isFromURL : Bool = true
    
    var video : YoutubeVideo? {
        didSet {
            //measure title text
            if let title = video?.title {
                titleLabel.text = title
                let size = CGSize(width: frame.width - leftSpacing - userProfileImageView.frame.width - midSpacing - rightSpacing, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
                let estimatedSize = NSString(string: title).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], context: nil)
                
                titleLabelHeightConstraint?.constant = estimatedSize.size.height > 20 ? 44 : 20
                
            }
            
            setupThumbnailImage()
            setupProfileImage()
            subtitleTextView.text = "\(video?.channel.name ?? "") • \((video?.numberOfViews ?? 0).stringWithSepator) views • \(video?.uploadDate ?? "")"
            
        }
    }
   
    func setupProfileImage(){
        if let profileImage = video?.channel.profileImageName{
            if isFromURL {
                self.userProfileImageView.loadImageUsingUrlString(with: profileImage)
            }else {
                userProfileImageView.image = UIImage(named: profileImage)
            }
        }
    }
    func setupThumbnailImage(){
        
        if let thumbnailImage = video?.thumbnailImageName{
            if isFromURL {
                self.thumbnailImageView.loadImageUsingUrlString(with: thumbnailImage)
            }else{
                thumbnailImageView.image = UIImage(named: thumbnailImage )
            }
        }
        
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22 //half height and width of image
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.font = UIFont.systemFont(ofSize: 11)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: /*bottomSpacing*/-4, bottom: 0, right: 0) 
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint : NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraints(with: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraints(with: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraints(with: "V:|-16-[v0]-8-[v1(44)]-40-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraints(with: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: midSpacing))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: midSpacing))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        if let heightConstraint = titleLabelHeightConstraint{
            addConstraint(heightConstraint)
        }
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: topSpacing))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: midSpacing))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
   
}



