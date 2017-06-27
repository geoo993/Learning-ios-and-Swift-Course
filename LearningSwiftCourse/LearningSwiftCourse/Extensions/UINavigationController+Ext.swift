//
//  Navigation+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 26/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation


extension UINavigationController {
    
    var rootViewControllerInNavigationStack : UIViewController? {
        return viewControllers.first 
    }
    
    func previousViewControllerInNavigationStack() -> UIViewController? {
        guard let _ = self.navigationController else {
            return nil
        }
        
        guard let viewControllers = self.navigationController?.viewControllers else {
            return nil
        }
        
        guard viewControllers.count >= 2 else {
            return nil
        }        
        return viewControllers[viewControllers.count - 2]
    }
}
