//
//  UIResponder+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller

import Foundation

public extension UIResponder {
    public func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {
                return nil
            }
        }
    }
    
    public func parentController<T: UIViewController>(of type: T.Type) -> T? {
        guard let next = self.next else {
            return nil
        }
        return (next as? T) ?? next.parentController(of: T.self)
    }
    
}

//let parentController = self.parentController(of: MyViewController.self)
