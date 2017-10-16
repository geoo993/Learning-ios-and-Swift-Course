//
//  ViewController.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

public class ZigZagScrollViewHomeViewController: UIViewController {

    @IBOutlet weak var scrollView: ZIgZagScrollView!
  
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTapGesture()
    }
   
    func setupTapGesture(){
        // Add tap to open
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        tapRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func handleTapGesture(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        scrollView.addViewToZigZag(at: scrollView.controlPoints.count)
        scrollView.setupBezierView()
    }
    
}


