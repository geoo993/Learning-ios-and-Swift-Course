//
//  UIScrollView+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

public extension UIScrollView {
    
    public func scrollToBottom(_ animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }

}
