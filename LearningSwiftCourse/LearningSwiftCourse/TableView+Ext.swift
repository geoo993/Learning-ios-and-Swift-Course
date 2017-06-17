//
//  TableView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func getAllCells() -> [UITableViewCell] {
        
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
