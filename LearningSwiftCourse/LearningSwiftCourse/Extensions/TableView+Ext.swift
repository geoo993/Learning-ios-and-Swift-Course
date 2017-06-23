//
//  TableView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    public func getAllCells() -> [UITableViewCell] {
        
        var cells = [UITableViewCell]()
        // assuming tableView is your self.tableView defined somewhere
        for i in 0..<self.numberOfSections
        {
            for j in 0..<self.numberOfRows(inSection:i)
            {
                if let cell = self.cellForRow(at: IndexPath(row: j, section: i) ) {
                    
                    cells.append(cell)
                }
                
            }
        }
        return cells
    }
    
}

public extension UITableViewCell {
    
    public func customSeperatorLine(withColor color: UIColor, separatorHeight: CGFloat){
        let screenSize = UIScreen.main.bounds
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, 
                                                            y: self.frame.size.height - separatorHeight, 
                                                            width: screenSize.width, 
                                                            height: separatorHeight))
        additionalSeparator.backgroundColor = color
        self.addSubview(additionalSeparator)
    }
}
