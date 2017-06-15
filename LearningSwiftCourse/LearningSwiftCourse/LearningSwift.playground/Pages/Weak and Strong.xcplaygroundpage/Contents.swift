
import Foundation
import UIKit

class Test {
    
    var myView = UIView()
    
    weak var target: UIView? {
        willSet {
            if newValue != nil { 
                print(newValue)
                print("target set to nil", "but my view is \(myView)") 
                myView = newValue ?? UIView()
            }
            else { 
                print("target set to view") 
            }
        }
    }
}

class Button {
    var view: UIView? = UIView()
}

var t = Test()
var b = Button()
t.target = b.view
//b.view = nil // t.target's willSet should be fired here
print(t.myView)
