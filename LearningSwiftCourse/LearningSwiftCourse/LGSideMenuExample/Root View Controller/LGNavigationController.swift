//
//  LGNavigationController.swift
//  LGSideMenuControllerDemo
//
import UIKit

class LGNavigationController: UINavigationController {

    override var shouldAutorotate : Bool {
        return true
    }
    
    override var prefersStatusBarHidden : Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape && UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        guard let isRightVisible = sideMenuController?.isRightViewVisible else { return UIStatusBarAnimation.none }
        return isRightVisible ? .slide : .fade
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("navigation controller view did load ")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("navigation controller view will appear ")
   
        
    }
}
