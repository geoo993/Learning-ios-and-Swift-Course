//
//  StorySmartiesScrollMenuViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 13/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

//https://stackoverflow.com/questions/29659360/swift-uidynamic-animate-panel-from-bottom-to-top

import UIKit
import RxSwift

class StorySmartiesScrollMenuViewController: UIViewController {

    // Mark : - Outlets and Actions
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var studentInfo: UIButton!
    
    @IBAction func studentTouchDown(_ sender: UIButton) {
        print("Touch Down")
        studentButton.backgroundColor = UIColor.gray
    }
    @IBAction func studentTouchUpInside(_ sender: UIButton) {
        print("Touch Up Inside", isPanelOpen)
        studentButton.backgroundColor = UIColor.clear
    }
    @IBAction func studentTouchUpOutside(_ sender: UIButton) {
        print("Touch Up Outside", isPanelOpen)
        studentButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func infoTouchDown(_ sender: UIButton) {
        print("Touch Down")
        studentInfo.backgroundColor = UIColor.gray
    }
    @IBAction func infoTouchUpInside(_ sender: UIButton) {
        print("Touch Up Inside")
        studentInfo.backgroundColor = UIColor.clear
    }
    @IBAction func infoTouchUpOutside(_ sender: UIButton) {
        print("Touch Up Outside")
        studentInfo.backgroundColor = UIColor.clear
    }
    
    @IBOutlet weak var panelView : PanelDrawerView!
    @IBOutlet weak var panelLabel : UILabel!
    
    var isPanelOpen = false
    var isStudent = false
    var isBookInfo = false
    
    // Mark : - Elements
    var disposable = DisposeBag()
    
    let scrollViewElements = ["😃", "🗣", "⭐️"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(panelView)
        
        let heightToSee : CGFloat = 60
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height / 2
        let frame = CGRect(x: 0, y: -height + heightToSee, width: width, height: height)
        
        panelView.frame = frame
        panelView.heightToSee = heightToSee
        panelView.maxHeight = height
        panelView.superViewHeight = self.view.bounds.size.height
        panelView.setup()
        
        
        studentButton.layer.borderColor = UIColor.systemsBlueColor.cgColor
        studentButton.layer.borderWidth = 1
        studentButton.rx.tap.subscribe(onNext: { tap in
            
            if self.isBookInfo {
                self.isBookInfo = false
                self.isStudent = true
            }else{
                self.isStudent = !self.isStudent
            }
            
            self.openStudentInfo()
            
        }).disposed(by: disposable)
        
        studentInfo.rx.tap.subscribe(onNext: { tap in
            
            if self.isStudent {
                self.isStudent = false
                self.isBookInfo = true
            }else{
                self.isBookInfo = !self.isBookInfo
            }
            self.openBookInfo()
            
        }).addDisposableTo(disposable)
        
        
        let elementwidth : CGFloat = 100
        let elementheight = scrollView.frame.size.height
        
        scrollView.removeSubviews()
        
        for i in 0..<scrollViewElements.count {
            
            let element = UILabel(frame: CGRect(x: 0, y: 0, width: elementwidth, height: elementheight ))
            
            element.frame.origin.x = CGFloat(i) * elementwidth
            
            element.text = "  " + scrollViewElements[i] + ": 200"
            element.clipsToBounds = true
            element.layer.masksToBounds = true
            element.font = element.font.withSize(12)
            
            scrollView.addSubview(element)
            
        }
        
        //calculate the content width
        let contentWidth = width * CGFloat(scrollViewElements.count)
        
        
        //set scrollView content size
        scrollView.contentSize = CGSize(width: contentWidth, height: elementheight)
        
    }
    
    func openStudentInfo(){
        if isStudent {
            panelLabel.text = "Student Info"
            shouldOpen(true)
            
        }else {
            shouldOpen(false)
        }
    }
    
    func openBookInfo(){
        if isBookInfo {
            panelLabel.text = "Book Info"
            shouldOpen(true)
        }else {
            shouldOpen(false)
        }
    }
    
    func shouldOpen(_ panel: Bool){
        if panel {
            //open when it is closed
            panelView.panGestureSnapToBottom()
            isPanelOpen = true
        }else{
            //close when it is open
            panelView.panGestureSnapToTop()
            isPanelOpen = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        studentButton.layer.cornerRadius = 12
        studentInfo.layer.cornerRadius = 11
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIScrollViewDelegate
extension StorySmartiesScrollMenuViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //update the page controls with the current page number
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //        if let scrol = (scrollView) as? InspirationalFilmsLabelsScrollView {
        //            self.filmsLabelsScrollView.contentSize = CGSize(width: scrol.contentSize.width, height: 0)
        //        }
    }
    
}
