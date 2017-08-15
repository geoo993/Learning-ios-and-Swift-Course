//
//  UIViewController+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 15/08/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

public extension UIViewController {
    var controllerAppDelegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
