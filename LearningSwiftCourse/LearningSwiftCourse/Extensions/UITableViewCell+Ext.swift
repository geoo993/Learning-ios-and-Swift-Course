//
//  UITableViewCell+Ext.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 03/10/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


public extension UITableViewCell
{
    func addSeparator(y: CGFloat, margin: CGFloat, color: UIColor, _ useFullWidth: Bool = false)
    {
        let width = useFullWidth ? UIScreen.main.bounds.width :self.frame.width
        let sepFrame = CGRect(x:margin,y: y, width: width - margin, height:0.7)
        let seperatorView = UIView(frame: sepFrame)
        seperatorView.backgroundColor = color
        self.addSubview(seperatorView)
    }
    
    public func addTopSeparator(tableView: UITableView)
    {
        let margin = tableView.separatorInset.left
        
        self.addSeparator(y: 0, margin: margin, color: tableView.separatorColor!)
    }
    
    public func addBottomSeparator(tableView: UITableView, cellHeight: CGFloat)
    {
        let margin = tableView.separatorInset.left
        
        //self.addSeparator(y: cellHeight - 2, margin: margin, color: tableView.separatorColor!)
        self.addSeparator(y: cellHeight - 2, margin: margin, color: tableView.separatorColor!, true)
    }
    
    public func removeSeparator(width: CGFloat)
    {
        self.separatorInset = UIEdgeInsetsMake(0.0, width, 0.0, 0.0)
    }
    
}
