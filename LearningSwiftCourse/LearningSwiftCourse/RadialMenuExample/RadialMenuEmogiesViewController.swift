//
//  RadialMenuEmogiesViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 04/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class RadialMenuEmogiesViewController: UIViewController {

    var tapView:UIView
    
    var showRadialMenu = false
    var radialMenu:RadialMenu!
    var firstPressLocation = CGPoint.zero
    
    let emogiIcons = ["🤡","😎","😡","👹","🎃","👮‍♀️","👽"]
    let menuRadius: CGFloat = 150.0
    let subMenuRadius: CGFloat = 20.0
    let colors = ["#C0392B", "#2ECC71", "#E67E22", "#3498DB", "#9B59B6", "#F1C40F",
                  "#16A085", "#8E44AD", "#2C3E50", "#F39C12", "#2980B9", "#27AE60",
                  "#D35400", "#34495E", "#E74C3C", "#1ABC9C"].map { UIColor(rgba: $0) }
    
    required init?(coder aDecoder: NSCoder) {
        tapView = UIView()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setupRadialMenu()
        setupLongPress()
        // Do any additional setup after loading the view.
    }
    
    
    func setupLongPress(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPress.minimumPressDuration = 1
        longPress.numberOfTouchesRequired = 1
        longPress.numberOfTapsRequired = 0
        view.addGestureRecognizer(longPress)
    }
    @objc func longPressed(_ gesture : UIGestureRecognizer) {
    
        print()
        
        let location = gesture.location(in: view)
        
        switch(gesture.state) {
        case .began:
            if showRadialMenu == false {
                setupRadialMenu()
                firstPressLocation = location
                self.radialMenu.openAtPosition(firstPressLocation)
                
                showRadialMenu = true
            }
        case .changed:
            
            if showRadialMenu == true {
                self.radialMenu.moveAtPosition(location)
            }
        case .ended:
            if showRadialMenu == true {
                self.radialMenu.close()
                showRadialMenu = false
            }
        default:
            break
        }
    }

    func removeRadialMenuView(){
        for subview in view.subviews {
            if (subview == radialMenu) {
                //print(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK - RadialSubMenu 
    func setupRadialMenu() {
        
        view.removeSubview(with: RadialMenu.self)
        
        if radialMenu != nil {
            radialMenu = nil
        }
        
        // Setup radial menu
        var subMenus: [RadialSubMenu] = []
        for i in 0..<emogiIcons.count {
            let img = emogiIcons[i].toUIImage(with: 30)
            subMenus.append( self.createSubMenuItem(i, image: img)  )
        }
        
        radialMenu = RadialMenu(menus: subMenus, radius: menuRadius)
        radialMenu.center = view.center
        radialMenu.openDelayStep = 0.05
        radialMenu.closeDelayStep = 0.00
        radialMenu.minAngle = 180
        radialMenu.maxAngle = 360
        radialMenu.activatedDelay = 1.0
        radialMenu.backgroundView.alpha = 0.0
        radialMenu.onClose = {
            for subMenu in self.radialMenu.subMenus {
                self.resetSubMenu(subMenu)
            }
        }
        radialMenu.onHighlight = { subMenu in
            self.highlightSubMenu(subMenu)
            
            let color = self.colorForSubMenu(subMenu).withAlphaComponent(1.0)
            
            // TODO: Add nice color transition
            self.view.backgroundColor = color
        }
        
        radialMenu.onUnhighlight = { subMenu in
            self.resetSubMenu(subMenu)
            self.view.backgroundColor = UIColor.white
        }
        
        radialMenu.onClose = {
            self.view.backgroundColor = UIColor.white
        }
        
        view.addSubview(radialMenu)
        
    }
    
    func createSubMenuItem(_ i: Int, image : UIImage?) -> RadialSubMenu {
        
        let frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(subMenuRadius*2), height: CGFloat(subMenuRadius*2))
        
        let imageV = UIImageView(image: image)
        imageV.frame = frame
        imageV.contentMode = .scaleAspectFit
        
        let subMenu = (image != nil) ? RadialSubMenu(imageView: imageV) : RadialSubMenu(frame: frame)
        subMenu.isUserInteractionEnabled = true
        subMenu.layer.cornerRadius = subMenuRadius
        subMenu.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        subMenu.layer.borderWidth = 1
        subMenu.tag = i
        resetSubMenu(subMenu)
        return subMenu
    }
    
    func colorForSubMenu(_ subMenu: RadialSubMenu) -> UIColor {
        let pos = subMenu.tag % colors.count
        return colors[pos] as UIColor!
    }
    
    func highlightSubMenu(_ subMenu: RadialSubMenu) {
        let color = colorForSubMenu(subMenu)
        subMenu.backgroundColor = color.withAlphaComponent(1.0)
    }
    
    func resetSubMenu(_ subMenu: RadialSubMenu) {
        let color = colorForSubMenu(subMenu)
        subMenu.backgroundColor = color.withAlphaComponent(0.75)
    }
    
    deinit {
        print("Radial Menu Emojies View Controller \(#function)")
    }

}
